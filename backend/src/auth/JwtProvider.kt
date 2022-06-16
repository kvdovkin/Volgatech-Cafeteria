package app.cafeteria.auth

import app.cafeteria.model.dto.UserDto
import com.auth0.jwt.JWT
import com.auth0.jwt.JWTVerifier
import com.auth0.jwt.algorithms.Algorithm
import io.ktor.config.*
import java.util.*

class JwtProvider(
    private val issuer: String,
    secret: String,
) {

    companion object {
        private const val VALIDITY_MS = 3_600_000 * 100 // 100 Hours

        fun fromConfig(config: ApplicationConfig) = JwtProvider(
            issuer = config.property("issuer").getString(),
            secret = config.property("secret").getString(),
        )
    }

    private val algorithm = Algorithm.HMAC512(secret)

    val verifier: JWTVerifier = JWT
        .require(algorithm)
        .withIssuer(issuer)
        .build()

    // TODO: provide refresh token, reduce validity time
    fun generateToken(user: UserDto): String = JWT.create()
        .withIssuer(issuer)
        .withSubject(user.id.toString())
        .withExpiresAt(expiration())
        .sign(algorithm)

    private fun expiration() = Date(System.currentTimeMillis() + VALIDITY_MS)
}
