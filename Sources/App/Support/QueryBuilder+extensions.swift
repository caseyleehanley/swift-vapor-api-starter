import Fluent

extension QueryBuilder where Model: Queryable {
    @discardableResult
    func filter(
        by key: QueryFilterKey<Model>
    ) -> Self {
        switch key.value {
        case .string(let values):
            self.group(key.filter == .notEq ? .and : .or) { group in
                for value in values {
                    if let value {
                        group.filter(.init(stringLiteral: key.name), key.filter.method, value)
                    } else {
                        group.filterNil(using: key)
                    }
                }
            }
        case .int(let values):
            self.group(key.filter == .notEq ? .and : .or) { group in
                for value in values {
                    if let value {
                        group.filter(.init(stringLiteral: key.name), key.filter.method, value)
                    } else {
                        group.filterNil(using: key)
                    }
                }
            }
        case .double(let values):
            self.group(key.filter == .notEq ? .and : .or) { group in
                for value in values {
                    if let value {
                        group.filter(.init(stringLiteral: key.name), key.filter.method, value)
                    } else {
                        group.filterNil(using: key)
                    }
                }
            }
        case .bool(let value):
            if let value {
                self.filter(.init(stringLiteral: key.name), key.filter.method, value)
            } else {
                self.filterNil(using: key)
            }
        case .uuid(let values):
            self.group(key.filter == .notEq ? .and : .or) { group in
                for value in values {
                    if let value {
                        group.filter(.init(stringLiteral: key.name), key.filter.method, value)
                    } else {
                        group.filterNil(using: key)
                    }
                }
            }
        case .date(let value):
            if let value {
                self.filter(.init(stringLiteral: key.name), key.filter.method, value)
            } else {
                self.filterNil(using: key)
            }
        }
        return self
    }
    
    @discardableResult
    func filter<Joined, Field>(
        _ joined: Joined.Type,
        _ field: KeyPath<Joined, Field>,
        _ keyName: String,
        by key: QueryFilterKey<Model>
    ) -> Self where Field: QueryableProperty, Joined: Schema, Joined == Field.Model {
        switch key.value {
        case .string(let values):
            self.group(key.filter == .notEq ? .and : .or) { group in
                for value in values {
                    if let value {
                        group.filter(joined, field, key.filter.method, value as! Field.Value)
                    } else {
                        group.filterNil(using: key, named: keyName)
                    }
                }
            }
        case .int(let values):
            self.group(key.filter == .notEq ? .and : .or) { group in
                for value in values {
                    if let value {
                        group.filter(joined, field, key.filter.method, value as! Field.Value)
                    } else {
                        group.filterNil(using: key, named: keyName)
                    }
                }
            }
        case .double(let values):
            self.group(key.filter == .notEq ? .and : .or) { group in
                for value in values {
                    if let value {
                        group.filter(joined, field, key.filter.method, value as! Field.Value)
                    } else {
                        group.filterNil(using: key, named: keyName)
                    }
                }
            }
        case .bool(let value):
            if let value {
                self.filter(joined, field, key.filter.method, value as! Field.Value)
            } else {
                self.filterNil(using: key, named: keyName)
            }
        case .uuid(let values):
            self.group(key.filter == .notEq ? .and : .or) { group in
                for value in values {
                    if let value {
                        group.filter(joined, field, key.filter.method, value as! Field.Value)
                    } else {
                        group.filterNil(using: key, named: keyName)
                    }
                }
            }
        case .date(let value):
            if let value {
                self.filter(joined, field, key.filter.method, value as! Field.Value)
            } else {
                self.filterNil(using: key, named: keyName)
            }
        }
        return self
    }
    
    @discardableResult
    func sort(
        by key: QuerySortKey<Model>
    ) -> Self {
        self.sort(.init(stringLiteral: key.name), key.direction)
        return self
    }
    
    @discardableResult
    private func filterNil(
        using key: QueryFilterKey<Model>,
        named name: String? = nil
    ) -> Self {
        switch key.filter {
        case .eq: self.filter(.sql(unsafeRaw: "\(name ?? key.name) IS NULL"))
        case .notEq: self.filter(.sql(unsafeRaw: "\(name ?? key.name) IS NOT NULL"))
        default: break
        }
        return self
    }
}
