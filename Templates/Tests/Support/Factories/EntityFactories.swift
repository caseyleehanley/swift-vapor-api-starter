@testable import App
import Fluent

extension <#Entity#>: TestableResource {
    typealias ModelFactory = <#Entity#>ModelFactory
    typealias CreateFactory = <#Entity#>CreateFactory
    typealias UpdateFactory = <#Entity#>UpdateFactory
}

struct <#Entity#>ModelFactory {
    let db: Database

    @discardableResult
    func make(
        name: String = "Swift"
    ) async throws -> <#Entity#>.Model {
        let <#entity#> = <#Entity#>.Model(
            name: name
        )
        try await <#entity#>.save(on: db)
        return <#entity#>
    }
}

struct <#Entity#>CreateFactory {
    let db: Database

    @discardableResult
    func make(
        name: String = "Swift"
    ) async throws -> <#Entity#>.Create {
        return <#Entity#>.Create(
            name: name
        )
    }
}

struct <#Entity#>UpdateFactory {
    let db: Database

    @discardableResult
    func make(
        name: String = "Swift"
    ) async throws -> <#Entity#>.Update {
        return <#Entity#>.Update(
            name: name
        )
    }
}
