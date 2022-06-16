package app.cafeteria.model.entity

import app.cafeteria.model.entity.tables.Dishes
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass
import org.jetbrains.exposed.dao.id.EntityID

class Dish(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<Dish>(Dishes)

    var name by Dishes.name
    var price by Dishes.price
    var imageUrl by Dishes.imageUrl
    var grams by Dishes.grams
    var category by Category referencedOn Dishes.category
}
