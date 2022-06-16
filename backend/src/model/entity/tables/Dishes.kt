package app.cafeteria.model.entity.tables

import org.jetbrains.exposed.dao.id.IntIdTable

object Dishes : IntIdTable() {
    val name = varchar("name", 50)
    val price = integer("price")
    val imageUrl = varchar("imageUrl", 256).nullable()
    val grams = integer("grams").nullable()
    val category = reference("category", Categories)
}
