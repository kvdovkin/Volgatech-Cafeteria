package app.cafeteria.model.dto

import app.cafeteria.model.dto.validation.requireDto
import app.cafeteria.model.entity.Menu
import kotlinx.serialization.Serializable

@Serializable
data class MenuDto(
    val id: Int,
    val name: String,
    val dishes: List<DishDto>,
) {
    companion object {
        fun fromEntity(menu: Menu) = MenuDto(
            menu.id.value,
            menu.name,
            menu.dishes.map {
                DishDto.fromEntity(it)
            },
        )
    }

    @Serializable
    data class Request(
        val name: String,
        val dishesIds: List<Int>,
    ) {
        init {
            requireDto(name.isNotBlank()) { "Name cannot be blank" }
            requireDto(dishesIds.isNotEmpty()) { "Dishes ids should contain at least 1 item" }
        }
    }
}
