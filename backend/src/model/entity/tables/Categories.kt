package app.cafeteria.model.entity.tables

import org.jetbrains.exposed.dao.id.IntIdTable

object Categories : IntIdTable() {
    val name = varchar("name", 50)
    val order = integer("order").uniqueIndex()
}
