package app.cafeteria.routing

import app.cafeteria.model.dto.UserRole
import app.cafeteria.routing.interceptors.requireRole
import app.cafeteria.services.DishService
import io.ktor.application.*
import io.ktor.auth.*
import io.ktor.http.*
import io.ktor.http.content.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.util.*

fun Route.dishesRouting(dishService: DishService, staticContent: StaticContent) {
    route("dishes") {
        authenticate {
            requireRole(UserRole.ADMIN) {
                get {
                    call.respond(dishService.getAll())
                }

                post {
                    call.respond(dishService.createDish(call.receive(), dishImageUrl = null))
                }

                delete("{id}") {
                    dishService.deleteDish(call.parameters.getOrFail<Int>("id"))
                    call.respond(HttpStatusCode.OK)
                }

                // FIXME: temp route name
                post("with-image") {
                    val multipart = call.receiveMultipart()

                    val imagePart = multipart.readPart() as? PartData.FileItem
                        ?: return@post call.respond(HttpStatusCode.BadRequest)

                    val dishDtoPart = multipart.readPart() as? PartData.FormItem
                        ?: return@post call.respond(HttpStatusCode.BadRequest)

                    val createdDish = dishService.createDishWithImage(imagePart, dishDtoPart, staticContent)
                    call.respond(HttpStatusCode.OK, createdDish)
                }
            }
        }
    }
}
