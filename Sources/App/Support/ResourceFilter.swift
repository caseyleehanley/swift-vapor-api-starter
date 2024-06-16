import Fluent

enum ResourceFilter: String, CaseIterable {
    case eq
    case notEq
    case eqLike
    case notEqLike
    case lt
    case gt
    case lte
    case gte
    case contains
    case notContains
    case containsPrefix
    case containsSuffix
    case containsLike
    case notContainsLike
    case containsPrefixLike
    case containsSuffixLike
    
    var method: DatabaseQuery.Filter.Method {
        switch self {
        case .eq: .equal
        case .notEq: .equality(inverse: true)
        case .eqLike: .custom("ILIKE")
        case .notEqLike: .custom("NOT ILIKE")
        case .lt: .lessThan
        case .gt: .greaterThan
        case .lte: .lessThanOrEqual
        case .gte: .greaterThanOrEqual
        case .contains: .contains(inverse: false, .anywhere)
        case .notContains: .contains(inverse: true, .anywhere)
        case .containsPrefix: .contains(inverse: false, .prefix)
        case .containsSuffix: .contains(inverse: false, .suffix)
        case .containsLike: .custom("ILIKE")
        case .notContainsLike: .custom("NOT ILIKE")
        case .containsPrefixLike: .custom("ILIKE")
        case .containsSuffixLike: .custom("ILIKE")
        }
    }
}
