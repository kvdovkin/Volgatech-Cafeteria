package app.cafeteria.routing.ext

import app.cafeteria.model.dto.UserDto
import io.ktor.application.*
import io.ktor.auth.*

val ApplicationCall.user
    get() = authentication.principal<UserDto>()
