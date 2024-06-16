@testable import App
import XCTVapor
import Testing

@Suite("Health Check")
final class RootControllerTests: AppTest {
    @Test("GET /ping") func ping() async throws {
        let response = try await app.sendRequest(.GET, "ping")
        #expect(response.status == .ok)
        #expect(response.body.string == "pong")
    }
}
