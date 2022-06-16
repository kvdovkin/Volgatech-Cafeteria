package app.cafeteria.routing

import app.cafeteria.auth.JwtProvider
import app.cafeteria.model.dto.AuthResponseDto
import app.cafeteria.model.dto.UserPasswordCredentialDto
import app.cafeteria.services.UserService
import io.ktor.application.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*

fun Route.usersRouting(userService: UserService, jwtProvider: JwtProvider) {
    route("users") {
        post("signup") {
            val credentials = call.receive<UserPasswordCredentialDto>().trimValues()

            when {
                !credentials.valid() -> {
                    call.respond(HttpStatusCode.BadRequest, "Password or name is too short")
                }
                userService.findUserByName(credentials.name) != null -> {
                    call.respond(HttpStatusCode.Conflict, "User exists")
                }
                else -> {
                    val createdUser = userService.createUser(credentials)
                    call.respond(AuthResponseDto(createdUser, jwtProvider.generateToken(createdUser)))
                }
            }
        }

        post("signin") {
            val credentials = call.receive<UserPasswordCredentialDto>().trimValues()
            val user = userService.findUserByCredentials(credentials)
                ?: return@post call.respond(HttpStatusCode.NotFound, "No user with these credentials")

            call.respond(AuthResponseDto(user, jwtProvider.generateToken(user)))
        }
    }
}

private const val NAME_MIN_LENGTH = 3
private const val PASSWORD_MIN_LENGTH = 6

private fun UserPasswordCredentialDto.valid(): Boolean {
    return (name.length >= NAME_MIN_LENGTH) && (password.length >= PASSWORD_MIN_LENGTH)
}
