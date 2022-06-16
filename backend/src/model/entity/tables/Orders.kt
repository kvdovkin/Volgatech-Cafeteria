package app.cafeteria.model.entity.tables

import app.cafeteria.model.dto.OrderStatus
import org.jetbrains.exposed.dao.id.IntIdTable
import org.jetbrains.exposed.sql.`java-time`.datetime

object Orders : IntIdTable() {
    val barcodeUrl = varchar("barcodeUrl", 256).nullable()
    val datetime = datetime("datetime")
    val status = enumeration("status", OrderStatus::class)
    val user = reference("user", Users)
}
