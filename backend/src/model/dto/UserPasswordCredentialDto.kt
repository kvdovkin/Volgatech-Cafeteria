package app.cafeteria.model.dto

import io.ktor.auth.*
import kotlinx.serialization.Serializable

@Serializable
data class UserPasswordCredentialDto(val name: String, val password: String) : Credential {
    fun trimValues() = copy(name = name.trim(), password = password.trim())
}
