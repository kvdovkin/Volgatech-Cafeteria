package app.cafeteria.services

import app.cafeteria.exceptions.NestedEntityNotFoundException
import app.cafeteria.model.dto.OrderDto
import app.cafeteria.model.dto.OrderStatus
import app.cafeteria.model.entity.DishOrder
import app.cafeteria.model.entity.Order
import app.cafeteria.model.entity.User
import app.cafeteria.model.entity.tables.Orders
import app.cafeteria.services.ext.transactionOnIO
import io.ktor.application.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import org.jetbrains.exposed.sql.SizedIterable
import org.jetbrains.exposed.sql.and
import java.time.LocalDateTime

class OrderService(private val dishService: DishService) {
    suspend fun createOrder(userId: Int, orderDto: OrderDto.Request): OrderDto = transactionOnIO {
        val distinctDishes = orderDto.dishes.distinct()
        val orderedDishEntities = dishService.findEntitiesById(distinctDishes.map { it.id })

        if (distinctDishes.size.toLong() != orderedDishEntities.count()) {
            val notFoundIds: Set<Int> = distinctDishes.map {
                it.id
            }.subtract(orderedDishEntities.map {
                it.id.value
            })

            throw NestedEntityNotFoundException("Dish", notFoundIds)
        }

        val placedOrder = Order.new {
            datetime = LocalDateTime.now()
            status = OrderStatus.PENDING
            user = User.findById(userId)!!
        }

        for (orderedDish in orderedDishEntities) {
            DishOrder.new {
                priceOfOne = orderedDish.price
                quantity = distinctDishes.find { orderedDish.id.value == it.id }!!.quantity
                dish = orderedDish
                order = placedOrder
            }
        }

        return@transactionOnIO OrderDto.fromEntity(placedOrder)
    }

    suspend fun getAllOfUser(userId: Int, filterByStatus: OrderStatus?): List<OrderDto> = transactionOnIO {
        val orders: SizedIterable<Order> = if (filterByStatus != null) {
            Order.find { (Orders.user eq userId) and (Orders.status eq filterByStatus) }
        } else {
            Order.find { Orders.user eq userId }
        }

        return@transactionOnIO orders.map { OrderDto.fromEntity(it) }
    }

    suspend fun completeOrder(id: Int): OrderDto = transactionOnIO {
        Order[id].apply { status = OrderStatus.COMPLETED }.let(OrderDto::fromEntity)
    }

    suspend fun cancelOrder(id: Int): OrderDto = transactionOnIO {
        Order[id].apply { status = OrderStatus.CANCELED }.let(OrderDto::fromEntity)
    }
}
