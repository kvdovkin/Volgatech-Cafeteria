package app.cafeteria.model.dto

import app.cafeteria.model.entity.User
import io.ktor.auth.*
import kotlinx.serialization.Serializable
import kotlinx.serialization.Transient

@Serializable
data class UserDto(
    val id: Int,
    val name: String,
    @Transient val role: UserRole = UserRole.CLIENT,
) : Principal {

    companion object {
        fun fromEntity(user: User) = UserDto(
            user.id.value,
            user.name,
            user.role,
        )
    }
}
