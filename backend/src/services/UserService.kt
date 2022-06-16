package app.cafeteria.services

import app.cafeteria.auth.sha256
import app.cafeteria.model.dto.UserDto
import app.cafeteria.model.dto.UserPasswordCredentialDto
import app.cafeteria.model.dto.UserRole
import app.cafeteria.model.entity.User
import app.cafeteria.model.entity.tables.Users
import app.cafeteria.services.ext.transactionOnIO
import org.jetbrains.exposed.sql.and
import org.jetbrains.exposed.sql.transactions.transaction

class UserService {
    // TODO: suspend
    fun findUserById(uid: Int) = transaction {
        User.findById(uid)?.let(UserDto::fromEntity)
    }

    suspend fun findUserByCredentials(credentials: UserPasswordCredentialDto): UserDto? = transactionOnIO {
        User.find {
            (Users.name eq credentials.name) and (Users.password eq sha256(credentials.password))
        }.firstOrNull()?.let(UserDto::fromEntity)
    }

    suspend fun findUserByName(name: String): UserDto? = transactionOnIO {
        User.find { Users.name eq name }.firstOrNull()?.let(UserDto::fromEntity)
    }

    suspend fun createUser(credentials: UserPasswordCredentialDto): UserDto = transactionOnIO {
        User.new {
            name = credentials.name
            password = sha256(credentials.password)
            role = UserRole.CLIENT
        }.let(UserDto::fromEntity)
    }
}
