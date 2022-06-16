package app.cafeteria.model.dto.validation

import app.cafeteria.exceptions.DtoValidationException

/**
 * @see [kotlin.require]
 */
inline fun requireDto(value: Boolean, lazyMessage: () -> String) {
    if (!value) {
        val message = lazyMessage()
        throw DtoValidationException(message)
    }
}
