# swift-vapor-api-starter

A starter template for a Swift Vapor application that serves a REST API and allows CRUD operations on its entities. An [example project](https://github.com/caseyleehanley/game-service) that uses this template is available as a separate repository.

## Table of Contents

[I. Introduction](#i-introduction)\
[II. Command Reference](#ii-command-reference)\
[III. Tutorial](#iii-tutorial)\
[IV. Key Concepts](#iv-key-concepts)\
[V. Testing](#v-testing)\
[VI. Troubleshooting](#vi-troubleshooting)\
[VII. FAQs](#vii-faqs)

## Dependencies

[[Swift](https://www.swift.org)]
[[Vapor](https://docs.vapor.codes)]
[[Fluent](https://docs.vapor.codes/fluent/overview/)]
[[Postgres](https://postgresapp.com)]
[[Xcode](https://developer.apple.com/xcode/)]
[[RapidAPI](https://mac-docs.rapidapi.com)]

<br/>

---

# I. Introduction

### Key Features

- Uses code generation via shell scripts to add new entities, reducing the amount of time spent writing boiler-plate code
- Provides a shared, flexible query interface backed by [Fluent](https://docs.vapor.codes/fluent/overview/) for filtering and sorting all entities, as well as including associated entities (e.g., `?name_containsPrefix=Swi`)
- Relies heavily on the concept of [DTOs](https://docs.vapor.codes/fluent/model/#data-transfer-object) for publicly exposed types, like those used when reading, creating, or updating entities from a client
- Uses [Swift Testing](https://developer.apple.com/documentation/testing/) for unit test coverage, with simple tests being generated automatically

This starter project provides an opinionated application structure so that developers can focus on writing the core logic for their service. While it may not be the ideal project structure for every developer, it can be adapted to any scenario by modifying the code-generation templates. By using template files in the `Templates/` directory, developers can use code generation to quickly add new entities with a single command: (e.g., `make resource schema=programming_languages`). If you're familiar with [Ruby on Rails](https://rubyonrails.org), it is similar to the [`rails generate scaffold`](https://guides.rubyonrails.org/v3.2/getting_started.html#getting-up-and-running-quickly-with-scaffolding) command.

![Screenshot of Terminal.app Code Generation Output](/assets/swift-vapor-api-starter-1.png)

While this project depends heavily on [Fluent](https://docs.vapor.codes/fluent/overview/) for its flexible query interface, it should be straightforward to swap out [Vapor](https://docs.vapor.codes) for another Swift server framework that's compatible with Fluent, if desired. For example, it should be possible to use [Hummingbird](https://github.com/hummingbird-project/hummingbird) and its [HummingbirdFluent](https://github.com/hummingbird-project/hummingbird-fluent) integration with relatively minimal code changes.

***DISCLAIMER**: The project was developed using [Swift 6](https://www.swift.org) and the [Xcode 16 Beta](https://developer.apple.com/xcode/).*

<br/>

---

# II. Command Reference

### Test
```console
$ make test
```
or run tests in Xcode.

### Run
```console
$ make run
```
or run in Xcode.

### Migrate
```console
$ make migrate
```

### Revert Last Migration Batch
```console
$ make revert
```

### Add a New Resource (e.g., `ProgrammingLanguage`)

```console
$ make resource schema=programming_languages
```

<br/>

---

# III. Tutorial

*This tutorial assumes you have made no changes to the starter template.*

First, make sure the server is running by using the `make run` command or using Xcode.

Next, open the `swift-vapor-api-starter.paw` file in [RapidAPI](https://mac-docs.rapidapi.com) to get started.

Try the `Health Check` query to make sure it's up and running:

![Screenshot of RapidAPI.app "Health Check" HTTP Response](/assets/swift-vapor-api-starter-2.png)

If you haven't already done so, try adding a new Resource backed by a database table named `programming_languages` via the command line:

```
make resource schema=programming_languages
```

![Screenshot of Terminal.app Code Generation Output](/assets/swift-vapor-api-starter-1.png)

Follow the prompts to finish the code generation, then restart the server and hop back over to RapidAPI. Try the `Create Programming Language` query:

![Screenshot of RapidAPI.app "Create Programming Language" HTTP Response](/assets/swift-vapor-api-starter-3.png)

After creating the programming language, try the `Get Programming Language` query:

![Screenshot of RapidAPI.app "Get Programming Language" HTTP Response](/assets/swift-vapor-api-starter-4.png)

Now try creating a few more programming languages using the `Create Programming Language` query, and then try the `Get Programming Languages` query:

![Screenshot of RapidAPI.app "Get Programming Languages" HTTP Response](/assets/swift-vapor-api-starter-5.png)

If all is working well, you should see a similar list. But it would be nice to sort the results by name. Try adding a `sortBy=name` URL query parameter:

![Screenshot of RapidAPI.app "Get Programming Languages" HTTP Response using "sortBy" Parameter](/assets/swift-vapor-api-starter-6.png)

Now try reversing the sort order by adding a `sortDirection=descending` URL query parameter:

![Screenshot of RapidAPI.app "Get Programming Languages" HTTP Response using "sortDirection" Parameter](/assets/swift-vapor-api-starter-7.png)

Now let's try adding a few more filters... First, let's fetch where `name=C`:

![Screenshot of RapidAPI.app "Get Programming Languages" HTTP Response using "name" Parameter](/assets/swift-vapor-api-starter-8.png)

Next, how about where `name_contains=C`:

![Screenshot of RapidAPI.app "Get Programming Languages" HTTP Response using "name_contains" Parameter](/assets/swift-vapor-api-starter-9.png)

And where `name_notContains=C`:

![Screenshot of RapidAPI.app "Get Programming Languages" HTTP Response using "name_notContains" Parameter](/assets/swift-vapor-api-starter-10.png)

Next, how about where `name_containsPrefix=C`:

![Screenshot of RapidAPI.app "Get Programming Languages" HTTP Response using "name_containsPrefix" Parameter](/assets/swift-vapor-api-starter-11.png)

Hopefully the power of a shared, flexible query interface is apparent. Of course, there are performance considerations to keep in mind at the database level. Opening up such a flexible query interface to clients can potentially lead to suboptimal queries that can impact database performance. However, as long as this limitation is known, this pattern can be very productive.

<br/>

---

# IV. Key Concepts

## Resource

A Resource is the primary conceptual representation of an entity in an application's data schema.

[Sources / App / Resources / ProgrammingLanguage.swift](Templates/Sources/App/Resources/Entity.swift):

```swift
struct ProgrammingLanguage: CRUDResource {
	static let path = "programming_languages"
	typealias Model = ProgrammingLanguageModel
	typealias Read = ProgrammingLanguageReadDTO
	typealias Create = ProgrammingLanguageCreateDTO
	typealias Update = ProgrammingLanguageUpdateDTO
}
```

Resources typically hold no logic of their own, but rather serve as a container to define a group of types that are related to a conceptual entity.

## Model

A Model represents the data structure that is stored as a table or collection in the database. Models are implemented using the [Fluent](https://docs.vapor.codes/fluent/overview/) ORM.

[Sources / App / Models / ProgrammingLanguageModel.swift](Templates/Sources/App/Models/EntityModel.swift):

```swift
typealias ProgrammingLanguageModel = ProgrammingLanguageModelV1

final class ProgrammingLanguageModelV1: ResourceModel, @unchecked Sendable {
	static let schema = "programming_languages"
	
	@ID(key: .id)
	var id: UUID?

	@Field(key: "name")
	var name: String
	
	init() {}

	init(
		id: UUID? = nil,
		name: String
	) {
		self.id = id
		self.name = name
	}
	
	func toRead() throws -> ProgrammingLanguage.Read {
		return .init(
			id: try self.requireID(),
			name: self.name
		)
	}
}
```

In this project, typealiases are used to version model types (e.g., `typealias ProgrammingLanguageModel = ProgrammingLanguageModelV1`), as this allows the database schema to change over time in a way that doesn't break older migrations. The typealias (`ProgrammingLanguageModel`) is used in application code by default, whereas the versioned model type (`ProgrammingLanguageModelV1`) is used in migration-related code.

Models should be able to be converted into their Resource's ReadDTO-conforming type. This conversion is used whenever the service sends records back to clients.

## DTOs

[DTOs](https://docs.vapor.codes/fluent/model/#data-transfer-object), or Data Transfer Objects, are separate types representing the data structure to be encoded/decoded by clients during create, read, and update operations. Maintaining separate types for Models and DTOs decouples the API from the database schema, allowing the schema to change without breaking the public interface.

[Sources / App / DTOs / ProgrammingLanguageDTOs.swift](Templates/Sources/App/DTOs/EntityDTOs.swift):

```swift
struct ProgrammingLanguageReadDTO: ReadDTO {
	let id: UUID
	let name: String
}

struct ProgrammingLanguageCreateDTO: CreateDTO {
	let name: String
	
	func toModel() throws -> ProgrammingLanguage.Model {
		return .init(
			name: self.name
		)
	}
}

struct ProgrammingLanguageUpdateDTO: UpdateDTO {
	let name: String?
	
	func apply(to model: ProgrammingLanguage.Model) {
		if let name {
			model.name = name
		}
	}
}
```

CreateDTO-conforming types should be able to be converted into their Resource's Model type. This conversion is used when clients send a `POST` request to create a new record.

UpdateDTO-conforming types should be able to apply their updates to an instance of their Resource's Model type. This method is used when clients send a `PUT` request to update a record.

## Controller

A Controller is a collection of routes related to a resource. Generally, a resource will have the following five routes to support all CRUD-like operations, but more routes can be added when necessary or convenient.

- `GET /programming_languages` (Get a list of all programming languages)
- `GET /programming_languages/:id` (Get a single programming language)
- `POST /programming_languages` (Create a new programming language)
- `PUT /programming_languages/:id` (Update a single programming language)
- `DELETE /programming_languages/:id` (Delete a single programming language)

[Sources / App / Controllers / ProgrammingLanguageController.swift](Templates/Sources/App/Controllers/EntityController.swift):

```swift
struct ProgrammingLanguageController: Controller {
	typealias Resource = ProgrammingLanguage
	
	func boot(routes: RoutesBuilder) throws {
		let group = routes.grouped(.init(stringLiteral: Resource.path))
		group.get(use: self.index)
		group.post(use: self.create)
		group.group(":id") { item in
			item.get(use: self.find)
			item.put(use: self.update)
			item.delete(use: self.delete)
		}
	}

	@Sendable
	func index(request: Request) async throws -> [Resource.Read] {
		let query = Resource.Model.query(on: request.db)
		if let relationKeys = try request.getRelationKeys(definedBy: Resource.Model.self) {
			query.includeRelations(keyedBy: relationKeys)
		}
		if let filterKeys = try request.getFilterKeys(definedBy: Resource.Model.self) {
			try query.filter(by: filterKeys)
		}
		if let sortKeys = try request.getSortKeys(definedBy: Resource.Model.self) {
			try query.sort(by: sortKeys)
		}
		return try await query.all().map { try $0.toRead() }
	}
	
	@Sendable
	func find(request: Request) async throws -> Resource.Read {
		// ...
	}

	@Sendable
	func create(request: Request) async throws -> Resource.Read {
		// ...
	}
	
	@Sendable
	func update(request: Request) async throws -> Resource.Read {
		// ...
	}

	@Sendable
	func delete(request: Request) async throws -> HTTPStatus {
		// ...
	}
}
```

The `index` method makes use of the shared, flexible query interface for filtering, sorting, and including associations by default. Queryable properties are specified by conforming to the `Queryable` protocol:

[Sources / App / Models / ProgrammingLanguageModel+Queryable.swift](Templates/Sources/App/Models/EntityModel+Queryable.swift):

```swift
extension ProgrammingLanguageModel: Queryable {
	enum FilterKeys: String, CaseIterable, QueryKey, TypedQueryKey {
		case name
		// ...
	}
	
	enum SortKeys: String, CaseIterable, QueryKey {
		case name
		// ...
	}
	
	enum RelationKeys: CaseIterable {}
}
```

## Migration

A Migration represents a set of changes to the database schema. In the context of a Resource, migrations can be used to create its backing database table, to add or remove columns as the model evolves over time, to seed data, or even to remove the table if it is no longer needed.

[Sources / App / Migrations / CreateProgrammingLanguage.swift](Templates/Sources/App/Migrations/CreateEntity.swift):

```swift
struct CreateProgrammingLanguage: AsyncMigration {
	func prepare(on database: Database) async throws {
		try await database.schema("programming_languages")
			.id()
			.field("name", .string, .required)
			.create()
	}

	func revert(on database: Database) async throws {
		try await database.schema("programming_languages").delete()
	}
}
```

In this project, versioned model types (e.g., `ProgrammingLanguageModelV1`) are used when referring to a Model type in a migration. This allows historical migrations to continue to compile as the database schema evolves over time.

## Middleware

[Model middleware](https://docs.vapor.codes/fluent/model/#lifecycle) are used to allow hooking into a Model's lifecycle events. This is useful when extra steps need to be taken before a Model instance is saved to, updated in, or deleted from the database. One common scenario is to add logging whenever records are created, updated, or deleted.

[Sources / App / Middleware / ProgrammingLanguageModelMiddleware.swift](Templates/Sources/App/Middleware/EntityModelMiddleware.swift):

```swift
struct ProgrammingLanguageModelMiddleware: AsyncModelMiddleware {
	func create(
		model: ProgrammingLanguageModel,
		on db: Database,
		next: AnyAsyncModelResponder
	) async throws {
		// Add code before create...
		try await next.create(model, on: db)
	}
	
	func update(
		model: ProgrammingLanguageModel,
		on db: any Database,
		next: any AnyAsyncModelResponder
	) async throws {
		// Add code before update...
		try await next.update(model, on: db)
	}
	
	func delete(
		model: ProgrammingLanguageModel,
		force: Bool,
		on db: any Database,
		next: any AnyAsyncModelResponder
	) async throws {
		// Add code before delete...
		try await next.delete(model, force: force, on: db)
	}
}
```

<br/>

---

# V. Testing

Tests are implemented using [Swift Testing](https://developer.apple.com/documentation/testing/). To make it easier to arrange test data within a test case, factories are implemented to allow for quick and flexible instantiation of Models and DTOs.

[Tests / ControllerTests / API / V1 / ProgrammingLanguageControllerTests.swift](Templates/Tests/ControllerTests/API/V1/EntityControllerTests.swift):

```swift
@Test("GET /api/v1/programming_languages")
func index() async throws {
	let factory = Resource.ModelFactory(db: app.db)
	for _ in 0..<5 { try await factory.make() }
	
	let response = try await perform(.GET, path)
	#expect(response.status == .ok)
	
	let reads = try response.content.decode([Resource.Read].self)
	#expect(reads.count == 5)
}
```

[Tests / Support / Factories / ProgrammingLanguageFactories.swift](Templates/Tests/Support/Factories/EntityFactories.swift):

```swift
struct ProgrammingLanguageModelFactory {
	let db: Database

	@discardableResult
	func make(
		name: String = "Swift"
	) async throws -> ProgrammingLanguage.Model {
		let programmingLanguage = ProgrammingLanguage.Model(
			name: name
		)
		try await programmingLanguage.save(on: db)
		return programmingLanguage
	}
}
```

Controller tests are particularly useful for quickly testing various query scenarios, such as the following:

`?name=Swift`\
`?name_contains=wif`\
`?name_containsPrefix=Sw`\
`?name_containsSuffix=ft`\
`?name_notEq=Objective-C`\
`?age=10`\
`?age_gt=9`\
`?age_gte=10`\
`?age_lt=11`\
`?age_lte=10`\
`?sortBy=name`\
`?sortBy=name&sortDirection=descending`\
etc...

For example:

```swift
@Test("?name_contains=C")
func filterByNameContains() async throws {
	let factory = Resource.ModelFactory(db: app.db)
	try await factory.make(name: "Swift")
	try await factory.make(name: "Objective-C")
	try await factory.make(name: "C")
	try await factory.make(name: "C++")
	try await factory.make(name: "Go")
	
	let response = try await perform(.GET, "\(path)?name_contains=C")
	#expect(response.status == .ok)
	
	let reads = try response.content.decode([Resource.Read].self)
	#expect(reads.count == 3)
}
```

<br/>

---

# VI. Troubleshooting

### Why Doesn't It Work?

- Check your database configuration in `configure.swift`. Is there a database running at that location with the specified name?
- Are you running on macOS 14?
- For general Vapor/Fluent questions, check out the [Vapor Discord](https://discord.com/invite/vapor)

<br/>

---

# VII. FAQs

**Does it work on Linux?**\
I don't know, I haven't tested it. But probably!

**Does it work with Swift < 6?**\
I don't know, I haven't tested it. But probably not, because of [Swift Testing](https://developer.apple.com/documentation/testing/) requirements.

**Does it work with Xcode < 16?**\
I don't know, I haven't tested it. But probably not, because of [Swift Testing](https://developer.apple.com/documentation/testing/) requirements.

**Does it work with other Swift server frameworks besides Vapor?**\
I don't know, I haven't tested it. But as long as that framework integrates with [Fluent](https://docs.vapor.codes/fluent/overview/), it should (with *relatively* minimal code changes).