enum OmittableOptional<T>: Codable & Equatable where T: Codable & Equatable {
    case some(T)
    case none
    case omitted
    
    var value: T? {
        switch self {
        case .some(let value):
            return value
        case .none, .omitted:
            return nil
        }
    }
}
