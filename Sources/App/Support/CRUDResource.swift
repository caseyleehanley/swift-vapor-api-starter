import Vapor
import Fluent

protocol CRUDResource {
    static var path: String { get }
    associatedtype Model: ResourceModel
    associatedtype Read: ReadDTO
    associatedtype Create: CreateDTO
    associatedtype Update: UpdateDTO
}

protocol ResourceModel: Model {
    associatedtype Read: ReadDTO
    func toRead() throws -> Read
}

protocol ReadDTO: Content {}

protocol CreateDTO: Content {
    associatedtype Model: ResourceModel
    func toModel() throws -> Model
}

protocol UpdateDTO: Content {}

protocol Controller: RouteCollection {
    associatedtype Resource: CRUDResource
    func boot(routes: RoutesBuilder) throws
    func index(request: Request) async throws -> [Resource.Read]
    func find(request: Request) async throws -> Resource.Read
    func create(request: Request) async throws -> Resource.Read
    func update(request: Request) async throws -> Resource.Read
    func delete(request: Request) async throws -> HTTPStatus
}
