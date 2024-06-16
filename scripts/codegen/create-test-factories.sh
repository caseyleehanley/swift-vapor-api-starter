#!/bin/bash

# Create test factories in `Tests/Support/Factories/<Entity>Factories.swift`

cp Templates/Tests/Support/Factories/EntityFactories.swift Tests/Support/Factories/$3Factories.swift
sed -i '' 's/<#Entity#>/'$3'/g' Tests/Support/Factories/$3Factories.swift
sed -i '' 's/<#entities#>/'$1'/g' Tests/Support/Factories/$3Factories.swift
sed -i '' 's/<#entity#>/'$4'/g' Tests/Support/Factories/$3Factories.swift
