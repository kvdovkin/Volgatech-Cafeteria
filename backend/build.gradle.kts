@file:Suppress("PropertyName")

val ktor_version: String by project
val kotlin_version: String by project
val kotlinx_coroutines_version: String by project
val logback_version: String by project
val exposed_version: String by project
val postgresql_version: String by project
val hikari_version: String by project
val kotlinx_serialization_version: String by project

plugins {
    application
    kotlin("jvm") version "1.4.21"
    kotlin("plugin.serialization") version "1.4.21"
}

group = "app.cafeteria"
version = "0.0.1"

application {
    mainClassName = "io.ktor.server.netty.EngineMain"
}

repositories {
    mavenLocal()
    jcenter()
    maven { url = uri("https://kotlin.bintray.com/ktor") }
}

dependencies {
    // Core
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8:$kotlin_version")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:$kotlinx_coroutines_version")
    implementation("io.ktor:ktor-server-netty:$ktor_version")
    implementation("ch.qos.logback:logback-classic:$logback_version")
    // Database
    implementation("org.jetbrains.exposed:exposed-core:$exposed_version")
    implementation("org.jetbrains.exposed:exposed-dao:$exposed_version")
    implementation("org.jetbrains.exposed:exposed-jdbc:$exposed_version")
    implementation("org.jetbrains.exposed:exposed-java-time:$exposed_version")
    implementation("org.postgresql:postgresql:$postgresql_version")
    implementation("com.zaxxer:HikariCP:$hikari_version")
    // Serialization
    implementation("io.ktor:ktor-serialization:$ktor_version")
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:$kotlinx_serialization_version")
    // Auth
    implementation("io.ktor:ktor-auth:$ktor_version")
    implementation("io.ktor:ktor-auth-jwt:$ktor_version")

    testImplementation("io.ktor:ktor-server-tests:$ktor_version")
}

kotlin.sourceSets["main"].kotlin.srcDirs("src")
kotlin.sourceSets["test"].kotlin.srcDirs("test")

sourceSets["main"].resources.srcDirs("resources")
sourceSets["test"].resources.srcDirs("testresources")
