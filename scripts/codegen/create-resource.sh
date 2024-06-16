#!/bin/bash

# Create resource in `Sources/App/Resources/<Entity>.swift`

cp Templates/Sources/App/Resources/Entity.swift Sources/App/Resources/$3.swift
sed -i '' 's/<#Entity#>/'$3'/g' Sources/App/Resources/$3.swift
sed -i '' 's/<#entities#>/'$1'/g' Sources/App/Resources/$3.swift
sed -i '' 's/<#entity#>/'$4'/g' Sources/App/Resources/$3.swift