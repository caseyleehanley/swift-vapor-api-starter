import Vapor
import Fluent

extension <#Entity#>Model: Queryable {
    enum FilterKeys: String, CaseIterable, QueryKey, TypedQueryKey {
        case name
        
        var implementation: QueryKeyImplementation {
            switch self {
            case .name: .standard
            }
        }
        
        var type: QueryKeyType {
            switch self {
            case .name: .string
            }
        }
    }
    
    enum SortKeys: String, CaseIterable, QueryKey {
        case name
        
        var implementation: QueryKeyImplementation {
            switch self {
            case .name: .standard
            }
        }
    }
    
    enum RelationKeys: CaseIterable {}
}

extension QueryBuilder where Model == <#Entity#>Model {
    @discardableResult
    func includeRelations(keyedBy keys: [QueryRelationKey<Model>]) -> Self {
        for key in keys {
            switch key.key {
                // Add code to include relations here...
            }
        }
        return self
    }
    
    @discardableResult
    func filter(by keys: [QueryFilterKey<Model>]) throws -> Self {
        for key in keys {
            switch key.implementation {
            case .standard: self.filter(by: key)
            case .custom:
                switch key.key {
                // Add code to implement custom filters here...
                default: throw Abort(.notImplemented)
                }
            }
        }
        return self
    }
    
    @discardableResult
    func sort(by keys: [QuerySortKey<Model>]) throws -> Self {
        for key in keys {
            switch key.implementation {
            case .standard: self.sort(by: key)
            case .custom:
                switch key.key {
                // Add code to implement custom sorts here...
                default: throw Abort(.notImplemented)
                }
            }
        }
        return self
    }
}
