import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

public func configure(_ app: Application) async throws {
    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "postgres",
        password: Environment.get("DATABASE_PASSWORD") ?? "",
        database: Environment.get("DATABASE_NAME") ?? "swift-vapor-api-starter",
        tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)

    // .e.g, app.databases.middleware.use(EntityModelMiddleware(), on: .psql)
    
    // .e.g, app.migrations.add(CreateEntity())
    
    try routes(app)
}
