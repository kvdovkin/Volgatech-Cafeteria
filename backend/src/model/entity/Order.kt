package app.cafeteria.model.entity

import app.cafeteria.model.entity.tables.DishOrders
import app.cafeteria.model.entity.tables.Orders
import org.jetbrains.exposed.dao.IntEntity
import org.jetbrains.exposed.dao.IntEntityClass
import org.jetbrains.exposed.dao.id.EntityID

class Order(id: EntityID<Int>) : IntEntity(id) {
    companion object : IntEntityClass<Order>(Orders)

    var barcodeUrl by Orders.barcodeUrl
    var datetime by Orders.datetime
    var status by Orders.status
    var user by User referencedOn Orders.user
    val dishes by DishOrder referrersOn DishOrders.order

    val totalCost by lazy {
        dishes.sumBy { it.priceOfOne * it.quantity }
    }
}
