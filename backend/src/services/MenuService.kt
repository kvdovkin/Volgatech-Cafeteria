package app.cafeteria.services

import app.cafeteria.exceptions.NestedEntityNotFoundException
import app.cafeteria.model.dto.MenuDto
import app.cafeteria.model.entity.ActiveMenu
import app.cafeteria.model.entity.Menu
import app.cafeteria.model.entity.tables.Menus
import app.cafeteria.services.ext.transactionOnIO
import org.jetbrains.exposed.sql.transactions.experimental.suspendedTransaction

class MenuService(private val dishService: DishService) {
    suspend fun createMenu(menuDto: MenuDto.Request): MenuDto = transactionOnIO {
        val ids = menuDto.dishesIds.distinct()
        val includedDishEntities = dishService.findEntitiesById(ids)

        // TODO: create util function to simplify code related to 'not found items'
        if (ids.size.toLong() != includedDishEntities.count()) {
            val notFoundIds: Set<Int> = ids.subtract(includedDishEntities.map { it.id.value })
            throw NestedEntityNotFoundException("Dish", notFoundIds)
        }

        // Many-to-many entity relations must be created in separate transactions
        // See https://github.com/JetBrains/Exposed/wiki/DAO#many-to-many-reference for details
        val menu = suspendedTransaction {
            Menu.new {
                name = menuDto.name
            }
        }

        suspendedTransaction {
            menu.dishes = includedDishEntities
        }

        return@transactionOnIO MenuDto.fromEntity(menu)
    }

    suspend fun findActive(search: String? = null): MenuDto? = transactionOnIO {
        val activeMenuId = ActiveMenu.all().firstOrNull()?.activeMenuId ?: return@transactionOnIO null

        val menuDto = Menu.find { Menus.id eq activeMenuId }.firstOrNull()?.let { menu ->
            // FIXME: do search in db query and not with .filter { }
            if (search != null) {
                val menuDto = MenuDto.fromEntity(menu)
                val filteredDishes = menuDto.dishes.filter { search.toLowerCase() in it.name.toLowerCase() }
                return@let menuDto.copy(dishes = filteredDishes)
            }

            MenuDto.fromEntity(menu)
        }

        return@transactionOnIO menuDto
    }

    suspend fun getAll(): List<MenuDto> = transactionOnIO {
        Menu.all().map { MenuDto.fromEntity(it) }
    }

    suspend fun updateActiveMenuId(menuId: Int): Unit = transactionOnIO {
        // Check that menu with `menuId` exists
        if (Menu.findById(menuId) == null) {
            throw NestedEntityNotFoundException("Menu", setOf(menuId))
        }

        val activeMenuIdHolder = ActiveMenu.all().firstOrNull()

        if (activeMenuIdHolder != null) {
            activeMenuIdHolder.activeMenuId = menuId
        } else {
            ActiveMenu.new {
                activeMenuId = menuId
            }
        }
    }

    suspend fun deleteMenu(id: Int) = transactionOnIO {
        Menu[id].delete()
    }
}
