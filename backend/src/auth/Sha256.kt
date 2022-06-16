package app.cafeteria.auth

import java.security.MessageDigest

private val hashAlgorithm = MessageDigest.getInstance("SHA-256")

private fun hashString(input: String): String {
    return hashAlgorithm
        .digest(input.toByteArray())
        .fold("", { str, it -> str + "%02x".format(it) })
}

// TODO: salt?
fun sha256(input: String) = hashString(input)
