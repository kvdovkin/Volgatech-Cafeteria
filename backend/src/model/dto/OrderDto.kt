package app.cafeteria.model.dto

import app.cafeteria.model.dto.serializers.LocalDateTimeAsStringSerializer
import app.cafeteria.model.dto.validation.requireDto
import app.cafeteria.model.entity.Order
import kotlinx.serialization.Serializable
import java.time.LocalDateTime

@Serializable
data class OrderDto(
    val id: Int,
    val barcodeUrl: String?,
    val status: OrderStatus,
    @Serializable(with = LocalDateTimeAsStringSerializer::class)
    val datetime: LocalDateTime,
    val totalCost: Int,
    val dishes: List<DishDto.InOrder>,
) {
    companion object {
        fun fromEntity(order: Order) = OrderDto(
            order.id.value,
            order.barcodeUrl,
            order.status,
            order.datetime,
            order.totalCost,
            order.dishes.map {
                DishDto.InOrder.fromEntity(it.dish, it.quantity)
            }
        )
    }

    @Serializable
    data class Request(
        val dishes: List<DishDto.InOrder.Request>
    ) {
        init {
            requireDto(dishes.isNotEmpty()) { "Dishes list must contain at least 1 item" }
        }
    }
}
