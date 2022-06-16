package app.cafeteria.model.entity.tables

import org.jetbrains.exposed.dao.id.IntIdTable

object ActiveMenus : IntIdTable() {
    val activeMenuId = integer("activeMenuId").uniqueIndex()
}
