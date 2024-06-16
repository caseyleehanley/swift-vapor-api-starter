@Suite("<#Entity#>: DTOs")
final class <#Entity#>DTOTests: AppTest {
    @Test("Create -> toModel()")
    func toModel() async throws {
        let create = try await <#Entity#>.CreateFactory(db: app.db).make()
        let model = try create.toModel()
        #expect(model.name == create.name)
    }
    
    @Test("Update -> apply(to:)")
    func apply() async throws {
        let oldName = "Swoft"
        let newName = "Swift"
        
        let model = try await <#Entity#>.ModelFactory(db: app.db).make(name: oldName)
        let updates = try await <#Entity#>.UpdateFactory(db: app.db).make(name: newName)
        updates.apply(to: model)
        #expect(model.name == newName)
    }
}
