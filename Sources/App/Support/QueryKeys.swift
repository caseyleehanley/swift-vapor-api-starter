import struct Foundation.UUID
import struct Foundation.Date
import Fluent

protocol Queryable {
    associatedtype FilterKeys: CaseIterable, QueryKey, TypedQueryKey, RawRepresentable
        where FilterKeys.RawValue == String
    associatedtype SortKeys: CaseIterable, QueryKey, RawRepresentable
        where SortKeys.RawValue == String
    associatedtype RelationKeys: CaseIterable
}

protocol QueryKey {
    var implementation: QueryKeyImplementation { get }
}

protocol TypedQueryKey {
    var type: QueryKeyType { get }
}

enum QueryKeyImplementation {
    case standard
    case custom
}

enum QueryKeyType: String {
    case string
    case int
    case double
    case bool
    case uuid
    case date
}

enum QueryKeyValue {
    case string([String?])
    case int([Int?])
    case double([Double?])
    case bool(Bool?)
    case uuid([UUID?])
    case date(Date?)
}

typealias QueryKeySortDirection = DatabaseQuery.Sort.Direction

struct QueryRelationKey<T: Queryable> {
    let key: T.RelationKeys
}

struct QueryFilterKey<T: Queryable> {
    let key: T.FilterKeys
    let name: String
    let implementation: QueryKeyImplementation
    let filter: ResourceFilter
    let value: QueryKeyValue
    
    init(from key: T.FilterKeys, filter: ResourceFilter = .eq, value: QueryKeyValue) {
        self.key = key
        self.name = key.rawValue
        self.implementation = key.implementation
        self.filter = filter
        self.value = value
    }
}

struct QuerySortKey<T: Queryable> {
    let key: T.SortKeys
    let name: String
    let implementation: QueryKeyImplementation
    let direction: QueryKeySortDirection
    
    init(from key: T.SortKeys, direction: QueryKeySortDirection) {
        self.key = key
        self.name = key.rawValue
        self.implementation = key.implementation
        self.direction = direction
    }
}
