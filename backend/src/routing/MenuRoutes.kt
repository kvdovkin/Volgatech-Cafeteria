package app.cafeteria.routing

import app.cafeteria.model.dto.UserRole
import app.cafeteria.routing.interceptors.requireRole
import app.cafeteria.services.MenuService
import io.ktor.application.*
import io.ktor.auth.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.util.*

fun Route.menusRouting(menuService: MenuService) {
    route("menus") {
        authenticate {
            route("active") {
                get {
                    val search = call.request.queryParameters["q"]
                    val menu = menuService.findActive(search)
                        ?: return@get call.respond(HttpStatusCode.NotFound, "No active menu set")

                    call.respond(HttpStatusCode.OK, menu)
                }

                put("{id}") {
                    menuService.updateActiveMenuId(call.parameters.getOrFail<Int>("id"))
                    call.respond(HttpStatusCode.OK)
                }
            }

            requireRole(UserRole.ADMIN) {
                get {
                    call.respond(HttpStatusCode.OK, menuService.getAll())
                }

                post {
                    call.respond(HttpStatusCode.OK, menuService.createMenu(call.receive()))
                }

                delete("{id}") {
                    menuService.deleteMenu(call.parameters.getOrFail<Int>("id"))
                    call.respond(HttpStatusCode.OK)
                }
            }
        }
    }
}
