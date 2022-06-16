package app.cafeteria.routing

import app.cafeteria.model.dto.OrderStatus
import app.cafeteria.routing.ext.user
import app.cafeteria.services.OrderService
import io.ktor.application.*
import io.ktor.auth.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.util.*

fun Route.ordersRouting(orderService: OrderService) {
    route("orders") {
        authenticate {
            get {
                val userId = call.user?.id ?: return@get call.respond(HttpStatusCode.Unauthorized)

                val filterByStatus = (call.request.queryParameters["status"])?.let { param ->
                    OrderStatus.values().find { it.name == param.toUpperCase() }
                }

                call.respond(HttpStatusCode.OK, orderService.getAllOfUser(userId, filterByStatus))
            }

            post {
                val userId = call.user?.id ?: return@post call.respond(HttpStatusCode.Unauthorized)
                call.respond(HttpStatusCode.OK, orderService.createOrder(userId, call.receive()))
            }

            put("{id}/complete") {
                call.respond(HttpStatusCode.OK, orderService.completeOrder(call.parameters.getOrFail<Int>("id")))
            }
        }
    }
}
