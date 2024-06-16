import Fluent

struct Create<#Entity#>: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("<#entities#>")
            .id()
            .field("name", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("<#entities#>").delete()
    }
}
