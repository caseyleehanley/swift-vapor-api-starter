import Vapor

extension Content {
    func encode(using encoder: JSONEncoder = JSONEncoder()) throws -> ByteBuffer? {
        let body = try encoder.encode(self)
        return ByteBuffer(data: body)
    }
}
