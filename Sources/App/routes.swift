import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get("ping") { req async in
        "pong"
    }

    try app.group("api", "v1") { v1 in
        // e.g., `try v1.register(collection: EntityController())`
    }
}
