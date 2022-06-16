package app.cafeteria.model.dto

import kotlinx.serialization.Serializable

@Serializable
data class AuthResponseDto(
    val user: UserDto,
    val token: String,
)
