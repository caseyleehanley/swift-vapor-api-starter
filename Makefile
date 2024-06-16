schema ?= # e.g., `programming_languages`

snake_case := $(shell ./scripts/singularize.sh $(schema)) 
PascalCase := $(shell ./scripts/snake-to-pascal.sh $(snake_case))
camelCase := $(shell ./scripts/snake-to-camel.sh $(snake_case))

resource:
	@./scripts/codegen/print-change-summary.sh $(schema) $(snake_case) $(PascalCase) $(camelCase)
	@./scripts/codegen/create-migration.sh $(schema) $(snake_case) $(PascalCase) $(camelCase)
	@./scripts/codegen/register-migration.sh $(schema) $(snake_case) $(PascalCase) $(camelCase)
	@./scripts/codegen/create-resource.sh $(schema) $(snake_case) $(PascalCase) $(camelCase)
	@./scripts/codegen/create-model.sh $(schema) $(snake_case) $(PascalCase) $(camelCase)
	@./scripts/codegen/create-middleware.sh $(schema) $(snake_case) $(PascalCase) $(camelCase)
	@./scripts/codegen/register-middleware.sh $(schema) $(snake_case) $(PascalCase) $(camelCase)
	@./scripts/codegen/create-dtos.sh $(schema) $(snake_case) $(PascalCase) $(camelCase)
	@./scripts/codegen/create-controller.sh $(schema) $(snake_case) $(PascalCase) $(camelCase)
	@./scripts/codegen/register-controller.sh $(schema) $(snake_case) $(PascalCase) $(camelCase)
	@./scripts/codegen/create-test-factories.sh $(schema) $(snake_case) $(PascalCase) $(camelCase)
	@./scripts/codegen/create-tests.sh $(schema) $(snake_case) $(PascalCase) $(camelCase)
	@echo "\nDone."

migrate:
	@swift run App migrate

revert:
	@swift run App migrate --revert

test:
	@swift test

run:
	@swift run
