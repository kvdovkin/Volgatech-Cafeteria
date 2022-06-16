package app.cafeteria.model.entity

import app.cafeteria.model.entity.tables.Categories
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass
import org.jetbrains.exposed.dao.id.EntityID

class Category(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<Category>(Categories)

    var name by Categories.name
    var order by Categories.order
}
