package app.cafeteria.routing

import app.cafeteria.model.dto.UserRole
import app.cafeteria.routing.interceptors.requireRole
import app.cafeteria.services.CategoryService
import io.ktor.application.*
import io.ktor.auth.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.util.*

fun Route.categoriesRouting(categoryService: CategoryService) {
    route("categories") {
        get {
            call.respond(categoryService.getAll())
        }

        authenticate {
            requireRole(UserRole.ADMIN) {
                post {
                    call.respond(HttpStatusCode.OK, categoryService.createCategory(call.receive()))
                }

                put("{id}") {
                    val id = call.parameters.getOrFail<Int>("id")
                    call.respond(HttpStatusCode.OK, categoryService.updateCategory(id, call.receive()))
                }

                delete("{id}") {
                    categoryService.deleteCategory(call.parameters.getOrFail<Int>("id"))
                    call.respond(HttpStatusCode.OK)
                }
            }
        }
    }
}
