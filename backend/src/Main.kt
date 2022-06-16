package app.cafeteria

import app.cafeteria.auth.JwtProvider
import app.cafeteria.exceptions.DtoValidationException
import app.cafeteria.exceptions.NestedEntityNotFoundException
import app.cafeteria.model.entity.tables.*
import app.cafeteria.routing.*
import app.cafeteria.services.*
import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import io.ktor.application.*
import io.ktor.auth.*
import io.ktor.auth.jwt.*
import io.ktor.features.*
import io.ktor.http.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.serialization.*
import io.ktor.utils.io.errors.*
import kotlinx.serialization.SerializationException
import org.jetbrains.exposed.dao.exceptions.EntityNotFoundException
import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.SchemaUtils
import org.jetbrains.exposed.sql.transactions.transaction

fun main(args: Array<String>): Unit = io.ktor.server.netty.EngineMain.main(args)

@Suppress("unused") // Referenced in application.conf
@JvmOverloads
fun Application.module(testing: Boolean = false) {
    setupDatabase()

    install(DefaultHeaders)

    install(ConditionalHeaders)

    install(ContentNegotiation) { json() }

    install(StatusPages) {
        // Note: when adding a new exception handler, try not to use
        // general exceptions such as IllegalArgumentException or IllegalStateException as they may contain
        // potentially sensitive data in their message
        exception<SerializationException> {
            val details = it.message?.split('\n')?.firstOrNull().orEmpty()
            call.respond(HttpStatusCode.BadRequest, "Malformed JSON body. $details")
        }
        exception<ParameterConversionException> { call.respond(HttpStatusCode.BadRequest, it.message!!) }
        exception<DtoValidationException> { call.respond(HttpStatusCode.BadRequest, it.message) }
        exception<EntityNotFoundException> { call.respond(HttpStatusCode.NotFound, it.message!!) }
        exception<NestedEntityNotFoundException> { call.respond(HttpStatusCode.BadRequest, it.message!!) }
        exception<IOException> { /* Log */ call.application.environment.log.error(it.message) }
    }

    // TODO: consider dependency injection
    val userService = UserService()
    val categoryService = CategoryService()
    val dishService = DishService(categoryService)
    val orderService = OrderService(dishService)
    val menuService = MenuService(dishService)
    val jwtProvider = JwtProvider.fromConfig(environment.config.config("jwt"))

    val staticContent: StaticContent = environment.config.config("static-content").let { cfg ->
        StaticContent(route = cfg.property("route").getString(), imagesFolderPath = cfg.property("images").getString())
    }

    // TODO: don't perform db access to verify jwt
    install(Authentication) {
        jwt {
            verifier(jwtProvider.verifier)
            validate { credential ->
                credential.payload.subject.toIntOrNull()?.let(userService::findUserById)
            }
        }
    }

    routing {
        route("api") {
            usersRouting(userService, jwtProvider)
            categoriesRouting(categoryService)
            dishesRouting(dishService, staticContent)
            ordersRouting(orderService)
            menusRouting(menuService)
        }
        staticRouting(staticContent)
    }
}

private fun setupDatabase() {
    Database.connect(HikariDataSource(HikariConfig("/database.properties")))
    createTables()
}

private fun createTables() {
    transaction {
        SchemaUtils.create(
            ActiveMenus,
            Categories,
            Dishes,
            DishOrders,
            MenuDishes,
            Menus,
            Orders,
            Users,
        )
    }
}
