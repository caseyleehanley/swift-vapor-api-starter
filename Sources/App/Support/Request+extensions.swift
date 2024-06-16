import Vapor

extension Request {
    func findByID<T: ResourceModel>() async throws -> T where T.IDValue == UUID {
        guard let id = try? self.parameters.require("id", as: UUID.self) else {
            logger.error("Missing :id parameter")
            throw Abort(.badRequest)
        }
        guard let model = try await T.find(id, on: self.db) else {
            logger.error("Model not found for id: \(id)")
            throw Abort(.notFound)
        }
        return model
    }
    
    func content<T: Content>() throws -> T {
        do {
            let content = try self.content.decode(T.self)
            return content
        } catch {
            logger.error("\(error.localizedDescription)")
            throw Abort(.badRequest)
        }
        
    }
    
    func getRelationKeys<T: Queryable>(definedBy type: T.Type) throws -> [QueryRelationKey<T>]? {
        var relationKeys: [QueryRelationKey<T>] = []
        for key in T.RelationKeys.allCases {
            if let _ = try? self.query.get(String.self, at: "include_\(key)") {
                relationKeys.append(.init(key: key))
            }
        }
        return relationKeys.isEmpty ? nil : relationKeys
    }
    
    func getFilterKeys<T: Queryable>(definedBy type: T.Type) throws -> [QueryFilterKey<T>]? {
        var filterKeys: [QueryFilterKey<T>] = []
        for key in T.FilterKeys.allCases {
            switch key.type {
            case .string:
                if let value = try? self.query.get(String.self, at: "\(key)") {
                    let values = value.split(separator: ",").map(String.init).map({ $0 == "null" ? nil : $0 })
                    filterKeys.append(.init(from: key, value: .string(values)))
                }
            case .int:
                if let value = try? self.query.get(Int.self, at: "\(key)") {
                    filterKeys.append(.init(from: key, value: .int([value])))
                } else if let value = try? self.query.get(String.self, at: "\(key)") {
                    let values = value.split(separator: ",").map({ Int($0) })
                    filterKeys.append(.init(from: key, value: .int(values)))
                }
            case .double:
                if let value = try? self.query.get(Double.self, at: "\(key)") {
                    filterKeys.append(.init(from: key, value: .double([value])))
                } else if let value = try? self.query.get(String.self, at: "\(key)") {
                    let values = value.split(separator: ",").map({ Double($0) })
                    filterKeys.append(.init(from: key, value: .double(values)))
                }
            case .bool:
                if let value = try? self.query.get(Bool.self, at: "\(key)") {
                    filterKeys.append(.init(from: key, value: .bool(value)))
                } else if let value = try? self.query.get(String.self, at: "\(key)") {
                    if value == "null" {
                        filterKeys.append(.init(from: key, value: .bool(nil)))
                    }
                }
            case .uuid:
                if let value = try? self.query.get(UUID.self, at: "\(key)") {
                    filterKeys.append(.init(from: key, value: .uuid([value])))
                } else if let value = try? self.query.get(String.self, at: "\(key)") {
                    let values = value.split(separator: ",").map(String.init).map({ UUID(uuidString: $0) })
                    filterKeys.append(.init(from: key, value: .uuid(values)))
                }
            case .date:
                if let value = try? self.query.get(Date.self, at: "\(key)") {
                    filterKeys.append(.init(from: key, value: .date(value)))
                } else if let value = try? self.query.get(String.self, at: "\(key)") {
                    if value == "null" {
                        filterKeys.append(.init(from: key, value: .date(nil)))
                    }
                }
            }
            for filter in ResourceFilter.allCases {
                switch key.type {
                case .string:
                    if let value = try? self.query.get(String.self, at: "\(key)_\(filter.rawValue)") {
                        let values = value.split(separator: ",").map(String.init)
                        filterKeys.append(.init(from: key, filter: filter, value: .string(values)))
                    }
                case .int:
                    if let value = try? self.query.get(Int.self, at: "\(key)_\(filter.rawValue)") {
                        filterKeys.append(.init(from: key, filter: filter, value: .int([value])))
                    } else if let value = try? self.query.get(String.self, at: "\(key)_\(filter.rawValue)") {
                        let values = value.split(separator: ",").map({ Int($0) })
                        filterKeys.append(.init(from: key, filter: filter, value: .int(values)))
                    }
                case .double:
                    if let value = try? self.query.get(Double.self, at: "\(key)_\(filter.rawValue)") {
                        filterKeys.append(.init(from: key, filter: filter, value: .double([value])))
                    } else if let value = try? self.query.get(String.self, at: "\(key)_\(filter.rawValue)") {
                        let values = value.split(separator: ",").map({ Double($0) })
                        filterKeys.append(.init(from: key, filter: filter, value: .double(values)))
                    }
                case .bool:
                    if let value = try? self.query.get(Bool.self, at: "\(key)_\(filter.rawValue)") {
                        filterKeys.append(.init(from: key, filter: filter, value: .bool(value)))
                    }
                case .uuid:
                    if let value = try? self.query.get(UUID.self, at: "\(key)_\(filter.rawValue)") {
                        filterKeys.append(.init(from: key, filter: filter, value: .uuid([value])))
                    } else if let value = try? self.query.get(String.self, at: "\(key)_\(filter.rawValue)") {
                        let values = value.split(separator: ",").map(String.init).map({ UUID(uuidString: $0) })
                        filterKeys.append(.init(from: key, filter: filter, value: .uuid(values)))
                    }
                case .date:
                    if let value = try? self.query.get(Date.self, at: "\(key)_\(filter.rawValue)") {
                        filterKeys.append(.init(from: key, filter: filter, value: .date(value)))
                    }
                }
            }
        }
        return filterKeys.isEmpty ? nil : filterKeys
    }
    
    func getSortKeys<T: Queryable>(definedBy type: T.Type) throws -> [QuerySortKey<T>]? {
        var sortKeys: [QuerySortKey<T>] = []
        for key in T.SortKeys.allCases {
            if let sortKey = try? self.query.get(String.self, at: "sortBy"), sortKey == key.rawValue {
                if let sortDirection = try? self.query.get(String.self, at: "sortDirection") {
                    let direction: QueryKeySortDirection = sortDirection == "descending" ? .descending : .ascending
                    sortKeys.append(.init(from: key, direction: direction))
                } else {
                    sortKeys.append(.init(from: key, direction: .ascending))
                }
            }
        }
        return sortKeys.isEmpty ? nil : sortKeys
    }
}
