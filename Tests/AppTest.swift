@testable import App
import XCTVapor

class AppTest {
    let app: Application
    
    init() async throws {
        self.app = try await Application.make(.testing)
        try await configure(app)
        try await app.autoRevert()
        try await app.autoMigrate()
    }
    
    deinit {
        let semaphore = DispatchSemaphore(value: 0)
        Task { [app] in
            try await app.autoRevert()
            try await app.asyncShutdown()
            semaphore.signal()
        }
        semaphore.wait()
    }
    
    func perform(
        _ method: HTTPMethod,
        _ path: String,
        contentType: String = "application/json",
        content: ByteBuffer? = nil
    ) async throws -> XCTHTTPResponse {
        return try await app.sendRequest(
            method,
            path,
            headers: [
                "Content-Type": contentType
            ],
            body: content
        )
    }
}

protocol TestableResource {
    associatedtype ModelFactory
    associatedtype CreateFactory
    associatedtype UpdateFactory
}
