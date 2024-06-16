#!/bin/bash

# Create controller tests in `Tests/ControllerTests/API/V1/<Entity>ControllerTests.swift`
# Create model tests in `Tests/ModelTests/<Entity>ModelTests.swift`
# Create DTO tests in `Tests/DTOTests/<Entity>DTOTests.swift`

cp Templates/Tests/ControllerTests/API/V1/EntityControllerTests.swift Tests/ControllerTests/API/V1/$3ControllerTests.swift
sed -i '' 's/<#Entity#>/'$3'/g' Tests/ControllerTests/API/V1/$3ControllerTests.swift
sed -i '' 's/<#entities#>/'$1'/g' Tests/ControllerTests/API/V1/$3ControllerTests.swift
sed -i '' 's/<#entity#>/'$4'/g' Tests/ControllerTests/API/V1/$3ControllerTests.swift

cp Templates/Tests/ModelTests/EntityModelTests.swift Tests/ModelTests/$3ModelTests.swift
sed -i '' 's/<#Entity#>/'$3'/g' Tests/ModelTests/$3ModelTests.swift
sed -i '' 's/<#entities#>/'$1'/g' Tests/ModelTests/$3ModelTests.swift
sed -i '' 's/<#entity#>/'$4'/g' Tests/ModelTests/$3ModelTests.swift

cp Templates/Tests/DTOTests/EntityDTOTests.swift Tests/DTOTests/$3DTOTests.swift
sed -i '' 's/<#Entity#>/'$3'/g' Tests/DTOTests/$3DTOTests.swift
sed -i '' 's/<#entities#>/'$1'/g' Tests/DTOTests/$3DTOTests.swift
sed -i '' 's/<#entity#>/'$4'/g' Tests/DTOTests/$3DTOTests.swift