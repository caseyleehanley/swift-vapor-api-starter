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
                        switch key.filter {
                        case .eq: group.filter(.sql(unsafeRaw: "\(key.name) IS NULL"))
                        case .notEq: group.filter(.sql(unsafeRaw: "\(key.name) IS NOT NULL"))
                        default: continue
                        }
                    }
                }
            }
        case .int(let values):
            self.group(key.filter == .notEq ? .and : .or) { group in
                for value in values {
                    if let value {
                        group.filter(.init(stringLiteral: key.name), key.filter.method, value)
                    } else {
                        switch key.filter {
                        case .eq: group.filter(.sql(unsafeRaw: "\(key.name) IS NULL"))
                        case .notEq: group.filter(.sql(unsafeRaw: "\(key.name) IS NOT NULL"))
                        default: continue
                        }
                    }
                }
            }
        case .double(let values):
            self.group(key.filter == .notEq ? .and : .or) { group in
                for value in values {
                    if let value {
                        group.filter(.init(stringLiteral: key.name), key.filter.method, value)
                    } else {
                        switch key.filter {
                        case .eq: group.filter(.sql(unsafeRaw: "\(key.name) IS NULL"))
                        case .notEq: group.filter(.sql(unsafeRaw: "\(key.name) IS NOT NULL"))
                        default: continue
                        }
                    }
                }
            }
        case .bool(let value):
            if let value {
                self.filter(.init(stringLiteral: key.name), key.filter.method, value)
            } else {
                switch key.filter {
                case .eq: self.filter(.sql(unsafeRaw: "\(key.name) IS NULL"))
                case .notEq: self.filter(.sql(unsafeRaw: "\(key.name) IS NOT NULL"))
                default: break
                }
            }
        case .uuid(let values):
            self.group(key.filter == .notEq ? .and : .or) { group in
                for value in values {
                    if let value {
                        group.filter(.init(stringLiteral: key.name), key.filter.method, value)
                    } else {
                        switch key.filter {
                        case .eq: group.filter(.sql(unsafeRaw: "\(key.name) IS NULL"))
                        case .notEq: group.filter(.sql(unsafeRaw: "\(key.name) IS NOT NULL"))
                        default: continue
                        }
                    }
                }
            }
        case .date(let value):
            if let value {
                self.filter(.init(stringLiteral: key.name), key.filter.method, value)
            } else {
                switch key.filter {
                case .eq: self.filter(.sql(unsafeRaw: "\(key.name) IS NULL"))
                case .notEq: self.filter(.sql(unsafeRaw: "\(key.name) IS NOT NULL"))
                default: break
                }
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
                        switch key.filter {
                        case .eq: group.filter(.sql(unsafeRaw: "\(keyName) IS NULL"))
                        case .notEq: group.filter(.sql(unsafeRaw: "\(keyName) IS NOT NULL"))
                        default: continue
                        }
                    }
                }
            }
        case .int(let values):
            self.group(key.filter == .notEq ? .and : .or) { group in
                for value in values {
                    if let value {
                        group.filter(joined, field, key.filter.method, value as! Field.Value)
                    } else {
                        switch key.filter {
                        case .eq: group.filter(.sql(unsafeRaw: "\(keyName) IS NULL"))
                        case .notEq: group.filter(.sql(unsafeRaw: "\(keyName) IS NOT NULL"))
                        default: continue
                        }
                    }
                }
            }
        case .double(let values):
            self.group(key.filter == .notEq ? .and : .or) { group in
                for value in values {
                    if let value {
                        group.filter(joined, field, key.filter.method, value as! Field.Value)
                    } else {
                        switch key.filter {
                        case .eq: group.filter(.sql(unsafeRaw: "\(keyName) IS NULL"))
                        case .notEq: group.filter(.sql(unsafeRaw: "\(keyName) IS NOT NULL"))
                        default: continue
                        }
                    }
                }
            }
        case .bool(let value):
            if let value {
                self.filter(joined, field, key.filter.method, value as! Field.Value)
            } else {
                switch key.filter {
                case .eq: self.filter(.sql(unsafeRaw: "\(keyName) IS NULL"))
                case .notEq: self.filter(.sql(unsafeRaw: "\(keyName) IS NOT NULL"))
                default: break
                }
            }
        case .uuid(let values):
            self.group(key.filter == .notEq ? .and : .or) { group in
                for value in values {
                    if let value {
                        group.filter(joined, field, key.filter.method, value as! Field.Value)
                    } else {
                        switch key.filter {
                        case .eq: group.filter(.sql(unsafeRaw: "\(keyName) IS NULL"))
                        case .notEq: group.filter(.sql(unsafeRaw: "\(keyName) IS NOT NULL"))
                        default: continue
                        }
                    }
                }
            }
        case .date(let value):
            if let value {
                self.filter(joined, field, key.filter.method, value as! Field.Value)
            } else {
                switch key.filter {
                case .eq: self.filter(.sql(unsafeRaw: "\(keyName) IS NULL"))
                case .notEq: self.filter(.sql(unsafeRaw: "\(keyName) IS NOT NULL"))
                default: break
                }
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
}
