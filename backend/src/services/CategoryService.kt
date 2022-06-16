package app.cafeteria.services

import app.cafeteria.model.dto.CategoryDto
import app.cafeteria.model.entity.Category
import app.cafeteria.model.entity.tables.Categories
import app.cafeteria.services.ext.transactionOnIO
import org.jetbrains.exposed.sql.max
import org.jetbrains.exposed.sql.selectAll

class CategoryService {
    suspend fun createCategory(categoryDto: CategoryDto.Request): CategoryDto = transactionOnIO {
        Category.new {
            name = categoryDto.name
            // Set correct order for the new category
            val maxExpr = Categories.order.max()
            order = Categories.slice(maxExpr).selectAll().firstOrNull()?.get(maxExpr)?.plus(1) ?: 0
        }.let(CategoryDto::fromEntity)
    }

    suspend fun findEntityById(id: Int): Category? = transactionOnIO {
        Category.findById(id)
    }

    suspend fun getAll(): List<CategoryDto> = transactionOnIO {
        Category.all().map { CategoryDto.fromEntity(it) }
    }

    suspend fun updateCategory(id: Int, new: CategoryDto.Request): CategoryDto = transactionOnIO {
        Category[id].apply { name = new.name }.let(CategoryDto::fromEntity)
    }

    suspend fun deleteCategory(id: Int) = transactionOnIO {
        Category[id].delete()
    }
}
