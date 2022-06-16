package app.cafeteria.routing.interceptors

import app.cafeteria.model.dto.UserRole
import app.cafeteria.routing.ext.user
import io.ktor.application.*
import io.ktor.auth.*
import io.ktor.http.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.util.pipeline.*

private val RequireRolePhase = PipelinePhase("RequireRole")

fun Route.requireRole(
    role: UserRole,
    build: Route.() -> Unit
): Route {
    val requireRoleRoute = this.createChild(object : RouteSelector(1.0) {
        override fun evaluate(context: RoutingResolveContext, segmentIndex: Int): RouteSelectorEvaluation =
            RouteSelectorEvaluation.Constant
    })

    requireRoleRoute.apply {
        insertPhaseAfter(ApplicationCallPipeline.Features, Authentication.ChallengePhase)
        insertPhaseAfter(Authentication.ChallengePhase, RequireRolePhase)
    }

    requireRoleRoute.intercept(RequireRolePhase) {
        application.environment.log.info("User role is ${call.user?.role}")
        if (call.user?.role == role) {
            proceed()
        } else {
            call.respond(
                HttpStatusCode.Forbidden,
                "Not enough permissions to access ${call.request.httpMethod.value} ${call.request.path()}"
            )
            return@intercept finish()
        }
    }

    build(requireRoleRoute)

    return requireRoleRoute
}
