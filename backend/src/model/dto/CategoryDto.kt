package app.cafeteria.model.dto

import app.cafeteria.model.dto.validation.requireDto
import app.cafeteria.model.entity.Category
import kotlinx.serialization.Serializable

@Serializable
data class CategoryDto(
    val id: Int,
    val name: String,
    val order: Int,
) {
    companion object {
        fun fromEntity(category: Category) = CategoryDto(
            category.id.value,
            category.name,
            category.order,
        )
    }

    @Serializable
    data class Request(
        val name: String,
    ) {
        init {
            requireDto(name.isNotBlank()) { "Name cannot be blank" }
        }
    }
}
