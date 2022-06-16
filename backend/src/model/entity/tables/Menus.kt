package app.cafeteria.model.entity.tables

import org.jetbrains.exposed.dao.id.IntIdTable

object Menus : IntIdTable() {
    val name = varchar("name", 50)
}
