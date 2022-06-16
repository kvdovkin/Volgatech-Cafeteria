package app.cafeteria.model.entity.tables

import org.jetbrains.exposed.dao.id.IntIdTable

object DishOrders : IntIdTable() {
    val priceOfOne = integer("priceOfOne")
    val quantity = integer("quantity")
    val dish = reference("dish", Dishes)
    val order = reference("order", Orders)
}
