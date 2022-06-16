package app.cafeteria.model.dto

import app.cafeteria.model.dto.validation.requireDto
import app.cafeteria.model.entity.Dish
import kotlinx.serialization.Serializable

@Serializable
data class DishDto(
    val id: Int,
    val name: String,
    val price: Int,
    val imageUrl: String?,
    val grams: Int?,
    val categoryId: Int,
) {
    companion object {
        fun fromEntity(dish: Dish) = DishDto(
            dish.id.value,
            dish.name,
            dish.price,
            dish.imageUrl,
            dish.grams,
            dish.category.id.value,
        )
    }

    @Serializable
    data class Request(
        val name: String,
        val price: Int,
        val grams: Int? = null,
        val categoryId: Int,
    ) {
        init {
            requireDto(name.isNotBlank()) { "Name cannot be blank" }
            requireDto(price >= 0) { "Price must be positive, was $price" }
            grams?.let {
                requireDto(it >= 0) { "Grams must be positive or null, was $it" }
            }
        }
    }

    @Serializable
    data class InOrder(
        val id: Int,
        val name: String,
        val price: Int,
        val imageUrl: String?,
        val grams: Int?,
        val categoryId: Int,
        val quantity: Int,
    ) {
        companion object {
            fun fromEntity(dish: Dish, quantity: Int) = InOrder(
                dish.id.value,
                dish.name,
                dish.price,
                dish.imageUrl,
                dish.grams,
                dish.category.id.value,
                quantity,
            )
        }

        @Serializable
        data class Request(
            val id: Int,
            val quantity: Int,
        )
    }
}
