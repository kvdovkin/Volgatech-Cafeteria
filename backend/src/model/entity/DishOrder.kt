package app.cafeteria.model.entity

import app.cafeteria.model.entity.tables.DishOrders
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass
import org.jetbrains.exposed.dao.id.EntityID

class DishOrder(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<DishOrder>(DishOrders)

    var priceOfOne by DishOrders.priceOfOne
    var quantity by DishOrders.quantity
    var dish by Dish referencedOn DishOrders.dish
    var order by Order referencedOn DishOrders.order
}
