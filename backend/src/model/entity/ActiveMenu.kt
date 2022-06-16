package app.cafeteria.model.entity

import app.cafeteria.model.entity.tables.ActiveMenus
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass
import org.jetbrains.exposed.dao.id.EntityID

class ActiveMenu(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<ActiveMenu>(ActiveMenus)

    var activeMenuId by ActiveMenus.activeMenuId
}
