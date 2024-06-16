import struct Foundation.UUID

struct <#Entity#>ReadDTO: ReadDTO {
    let id: UUID
    let name: String
}

struct <#Entity#>CreateDTO: CreateDTO {
    let name: String
    
    func toModel() throws -> <#Entity#>.Model {
        return .init(
            name: self.name
        )
    }
}

struct <#Entity#>UpdateDTO: UpdateDTO {
    let name: String?
    
    func apply(to model: <#Entity#>.Model) {
        if let name {
            model.name = name
        }
    }
}
