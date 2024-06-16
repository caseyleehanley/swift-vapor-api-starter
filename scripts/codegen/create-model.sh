#!/bin/bash

# Create model in `Sources/App/Models/<Entity>Model.swift`
# Conform model to Queryable protocol in `Sources/App/Models/<Entity>Model+Queryable.swift`

cp Templates/Sources/App/Models/EntityModel.swift Sources/App/Models/$3Model.swift
sed -i '' 's/<#Entity#>/'$3'/g' Sources/App/Models/$3Model.swift
sed -i '' 's/<#entities#>/'$1'/g' Sources/App/Models/$3Model.swift
sed -i '' 's/<#entity#>/'$4'/g' Sources/App/Models/$3Model.swift

cp Templates/Sources/App/Models/EntityModel+Queryable.swift Sources/App/Models/$3Model+Queryable.swift
sed -i '' 's/<#Entity#>/'$3'/g' Sources/App/Models/$3Model+Queryable.swift
sed -i '' 's/<#entities#>/'$1'/g' Sources/App/Models/$3Model+Queryable.swift
sed -i '' 's/<#entity#>/'$4'/g' Sources/App/Models/$3Model+Queryable.swift
