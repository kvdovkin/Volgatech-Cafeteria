package app.cafeteria.services.ext

import kotlinx.coroutines.Dispatchers
import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.Transaction
import org.jetbrains.exposed.sql.transactions.experimental.newSuspendedTransaction

/**
 * Executes [newSuspendedTransaction] on [Dispatchers.IO]
 */
suspend inline fun <T> transactionOnIO(
    db: Database? = null,
    transactionIsolation: Int? = null,
    crossinline statement: suspend Transaction.() -> T,
) = newSuspendedTransaction(Dispatchers.IO, db, transactionIsolation) {
    statement()
}