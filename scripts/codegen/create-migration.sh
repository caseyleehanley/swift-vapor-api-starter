#!/bin/bash

# Create migration in `Sources/App/Migrations/Create<Entity>.swift`

cp Templates/Sources/App/Migrations/CreateEntity.swift Sources/App/Migrations/Create$3.swift
sed -i '' 's/<#Entity#>/'$3'/g' Sources/App/Migrations/Create$3.swift
sed -i '' 's/<#entities#>/'$1'/g' Sources/App/Migrations/Create$3.swift
sed -i '' 's/<#entity#>/'$4'/g' Sources/App/Migrations/Create$3.swift
