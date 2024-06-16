import struct Foundation.UUID
import Fluent

typealias <#Entity#>Model = <#Entity#>ModelV1

final class <#Entity#>ModelV1: ResourceModel, @unchecked Sendable {
    static let schema = "<#entities#>"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    init() {}

    init(
        id: UUID? = nil,
        name: String
    ) {
        self.id = id
        self.name = name
    }
    
    func toRead() throws -> <#Entity#>.Read {
        return .init(
            id: try self.requireID(),
            name: self.name
        )
    }
}
