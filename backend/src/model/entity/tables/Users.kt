package app.cafeteria.model.entity.tables

import app.cafeteria.model.dto.UserRole
import org.jetbrains.exposed.dao.id.IntIdTable

object Users : IntIdTable() {
    val name = varchar("name", 50)
    val password = varchar("password", 64)
    val role = enumeration("role", UserRole::class)
}
