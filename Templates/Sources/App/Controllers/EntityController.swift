import Vapor

struct <#Entity#>Controller: Controller {
    typealias Resource = <#Entity#>
    
    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped(.init(stringLiteral: Resource.path))
        group.get(use: self.index)
        group.post(use: self.create)
        group.group(":id") { item in
            item.get(use: self.find)
            item.put(use: self.update)
            item.delete(use: self.delete)
        }
    }

    @Sendable
    func index(request: Request) async throws -> [Resource.Read] {
        let query = Resource.Model.query(on: request.db)
        if let relationKeys = try request.getRelationKeys(definedBy: Resource.Model.self) {
            query.includeRelations(keyedBy: relationKeys)
        }
        if let filterKeys = try request.getFilterKeys(definedBy: Resource.Model.self) {
            try query.filter(by: filterKeys)
        }
        if let sortKeys = try request.getSortKeys(definedBy: Resource.Model.self) {
            try query.sort(by: sortKeys)
        }
        return try await query.all().map { try $0.toRead() }
    }
    
    @Sendable
    func find(request: Request) async throws -> Resource.Read {
        let model: Resource.Model = try await request.findByID()
        return try model.toRead()
    }

    @Sendable
    func create(request: Request) async throws -> Resource.Read {
        let content: Resource.Create = try request.content()
        let model = try content.toModel()
        try await model.save(on: request.db)
        return try model.toRead()
    }
    
    @Sendable
    func update(request: Request) async throws -> Resource.Read {
        let updates: Resource.Update = try request.content()
        let model: Resource.Model = try await request.findByID()
        updates.apply(to: model)
        try await model.save(on: request.db)
        return try model.toRead()
    }

    @Sendable
    func delete(request: Request) async throws -> HTTPStatus {
        let model: Resource.Model = try await request.findByID()
        try await model.delete(on: request.db)
        return .noContent
    }
}
