#!/bin/bash

# Create Read/Create/Update DTOs in `Sources/App/DTOs/<Entity>DTOs.swift`

cp Templates/Sources/App/DTOs/EntityDTOs.swift Sources/App/DTOs/$3DTOs.swift
sed -i '' 's/<#Entity#>/'$3'/g' Sources/App/DTOs/$3DTOs.swift
sed -i '' 's/<#entities#>/'$1'/g' Sources/App/DTOs/$3DTOs.swift
sed -i '' 's/<#entity#>/'$4'/g' Sources/App/DTOs/$3DTOs.swift
