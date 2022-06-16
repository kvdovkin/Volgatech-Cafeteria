package app.cafeteria.model.entity.tables

import org.jetbrains.exposed.sql.ReferenceOption
import org.jetbrains.exposed.sql.Table

object MenuDishes : Table() {
    val menu = reference("menu", Menus, onDelete = ReferenceOption.CASCADE)
    val dish = reference("dish", Dishes, onDelete = ReferenceOption.CASCADE)
    override val primaryKey = PrimaryKey(menu, dish)
}
