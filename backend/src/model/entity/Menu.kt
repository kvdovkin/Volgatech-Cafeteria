package app.cafeteria.model.entity

import app.cafeteria.model.entity.tables.MenuDishes
import app.cafeteria.model.entity.tables.Menus
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass
import org.jetbrains.exposed.dao.id.EntityID

class Menu(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<Menu>(Menus)

    var name by Menus.name
    var dishes by Dish via MenuDishes
}
