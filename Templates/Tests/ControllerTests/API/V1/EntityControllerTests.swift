@testable import App
import XCTVapor
import Testing

@Suite("<#Entity#>: Controller")
final class <#Entity#>ControllerTests: AppTest {
    typealias Resource = <#Entity#>
    
    let path = "api/v1/<#entities#>"
    
    @Test("GET /api/v1/<#entities#>")
    func index() async throws {
        let factory = Resource.ModelFactory(db: app.db)
        for _ in 0..<5 { try await factory.make() }
        
        let response = try await perform(.GET, path)
        #expect(response.status == .ok)
        
        let reads = try response.content.decode([Resource.Read].self)
        #expect(reads.count == 5)
    }
    
    @Test("GET /api/v1/<#entities#>/:id")
    func find() async throws {
        let factory = Resource.ModelFactory(db: app.db)
        let id = try (try await factory.make()).requireID()
        
        let response = try await perform(.GET, "\(path)/\(id)")
        #expect(response.status == .ok)
        
        let read = try response.content.decode(Resource.Read.self)
        #expect(read.id == id)
    }
    
    @Test("POST /api/v1/<#entities#>")
    func create() async throws {
        let name = "Swift"
        
        let factory = Resource.CreateFactory(db: app.db)
        let content = try await factory.make(name: name).encode()
        
        let response = try await perform(.POST, path, content: content)
        #expect(response.status == .ok)
        
        let read = try response.content.decode(Resource.Read.self)
        #expect(read.name == name)
    }
    
    @Test("PUT /api/v1/<#entities#>/:id")
    func update() async throws {
        let oldName = "Swoft"
        let newName = "Swift"
        
        let modelFactory = Resource.ModelFactory(db: app.db)
        let id = try (try await modelFactory.make(name: oldName)).requireID()
        
        let updateFactory = Resource.UpdateFactory(db: app.db)
        let content = try await updateFactory.make(name: newName).encode()
        
        let response = try await perform(.PUT, "\(path)/\(id)", content: content)
        #expect(response.status == .ok)
        
        let read = try response.content.decode(Resource.Read.self)
        #expect(read.name == newName)
    }
    
    @Test("DELETE /api/v1/<#entities#>/:id")
    func delete() async throws {
        let factory = Resource.ModelFactory(db: app.db)
        let id = try (try await factory.make()).requireID()
        
        let response = try await app.sendRequest(.DELETE, "\(path)/\(id)")
        #expect(response.status == .noContent)
    }
}
