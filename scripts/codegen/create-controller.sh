#!/bin/bash

# Create controller in `Sources/App/Controllers/<Entity>Controller.swift`

cp Templates/Sources/App/Controllers/EntityController.swift Sources/App/Controllers/$3Controller.swift
sed -i '' 's/<#Entity#>/'$3'/g' Sources/App/Controllers/$3Controller.swift
sed -i '' 's/<#entities#>/'$1'/g' Sources/App/Controllers/$3Controller.swift
sed -i '' 's/<#entity#>/'$4'/g' Sources/App/Controllers/$3Controller.swift