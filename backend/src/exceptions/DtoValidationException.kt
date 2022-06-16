package app.cafeteria.exceptions

/**
 * See [app.cafeteria.model.dto.validation.requireDto]
 */
class DtoValidationException(override val message: String) : Exception(message)
