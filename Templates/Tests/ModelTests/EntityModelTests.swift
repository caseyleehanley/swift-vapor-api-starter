@testable import App
import XCTVapor
import Testing

@Suite("<#Entity#>: Models")
final class <#Entity#>ModelTests: AppTest {
    @Test("toRead()")
    func toRead() async throws {
        let model = try await <#Entity#>.ModelFactory(db: app.db).make()
        let read = try model.toRead()
        #expect(model.name == read.name)
    }
}
