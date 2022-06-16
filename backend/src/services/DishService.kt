package app.cafeteria.services

import app.cafeteria.exceptions.DtoValidationException
import app.cafeteria.exceptions.NestedEntityNotFoundException
import app.cafeteria.model.dto.DishDto
import app.cafeteria.model.entity.Dish
import app.cafeteria.model.entity.tables.Dishes
import app.cafeteria.routing.StaticContent
import app.cafeteria.services.ext.transactionOnIO
import io.ktor.application.*
import io.ktor.http.*
import io.ktor.http.content.*
import io.ktor.response.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import org.jetbrains.exposed.sql.SizedIterable
import java.io.File
import java.util.*

class DishService(private val categoryService: CategoryService) {
    suspend fun createDish(dishDto: DishDto.Request, dishImageUrl: String?): DishDto = transactionOnIO {
        val assignedCategory = categoryService.findEntityById(dishDto.categoryId)
            ?: throw NestedEntityNotFoundException("Category", setOf(dishDto.categoryId))

        Dish.new {
            name = dishDto.name
            price = dishDto.price
            grams = dishDto.grams
            category = assignedCategory
            imageUrl = dishImageUrl
        }.let(DishDto::fromEntity)
    }

    suspend fun createDishWithImage(
        filePart: PartData.FileItem,
        dishDtoPart: PartData.FormItem,
        staticContent: StaticContent,
    ): DishDto {
        val dishDto = Json.decodeFromString<DishDto.Request>(dishDtoPart.value)

        /* Process image file part */

        val acceptedContentType = arrayOf(ContentType.Image.PNG, ContentType.Image.JPEG)

        if (filePart.contentType !in acceptedContentType) {
            val msg = "File must be one of [${acceptedContentType.joinToString()}], was ${filePart.contentType}"
            throw DtoValidationException(msg)
        }

        // This should never throw
        val ext = filePart.contentType?.fileExtensions()?.firstOrNull()
            ?: throw DtoValidationException("File with this mime type cannot be processed")

        val file = File(staticContent.imagesFolderPath, "Dish-${UUID.randomUUID()}.$ext")

        return withContext(Dispatchers.IO) {
            // Save to disk on Dispatchers.IO
            filePart.streamProvider().use { input ->
                file.outputStream().buffered().use { output ->
                    input.copyTo(output)
                }
            }

            return@withContext createDish(dishDto, dishImageUrl = "${staticContent.route}/${file.name}")
        }
    }

    suspend fun getAll() = transactionOnIO {
        Dish.all().map { DishDto.fromEntity(it) }
    }

    suspend fun findEntitiesById(ids: List<Int>): SizedIterable<Dish> = transactionOnIO {
        Dish.find { Dishes.id inList ids }
    }

    suspend fun deleteDish(id: Int) = transactionOnIO {
        Dish[id].delete()
    }
}
