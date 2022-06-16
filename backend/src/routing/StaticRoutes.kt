package app.cafeteria.routing

import io.ktor.http.content.*
import io.ktor.routing.*
import java.io.File

fun Route.staticRouting(staticContent: StaticContent) {
    static(staticContent.route) {
        val imagesFolder = File(staticContent.imagesFolderPath).apply {
            mkdirs()
        }

        // Serve files from that folder via `this` route
        files(imagesFolder)
    }
}
