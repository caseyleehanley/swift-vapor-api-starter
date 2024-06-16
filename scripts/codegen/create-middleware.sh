#!/bin/bash

# Create middleware in `Sources/App/Middleware/<Entity>ModelMiddleware.swift`

cp Templates/Sources/App/Middleware/EntityModelMiddleware.swift Sources/App/Middleware/$3ModelMiddleware.swift
sed -i '' 's/<#Entity#>/'$3'/g' Sources/App/Middleware/$3ModelMiddleware.swift
sed -i '' 's/<#entities#>/'$1'/g' Sources/App/Middleware/$3ModelMiddleware.swift
sed -i '' 's/<#entity#>/'$4'/g' Sources/App/Middleware/$3ModelMiddleware.swift
