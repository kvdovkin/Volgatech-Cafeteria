package app.cafeteria.model.dto

import kotlinx.serialization.Serializable

@Serializable
enum class UserRole {
    CLIENT,
    ADMIN
}
