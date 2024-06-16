#!/bin/bash

# Register migration in `Sources/App/configure.swift`

INSERT_CONTENT=$(cat Templates/Sources/App/configure-migration.swift)
INSERT_CONTENT=$(echo $INSERT_CONTENT | sed "s/<#Entity#>/$3/g")
INSERT_CONTENT=$(echo $INSERT_CONTENT | sed "s/<#entities#>/$1/g")
INSERT_CONTENT=$(echo $INSERT_CONTENT | sed "s/<#entity#>/$4/g")

awk -v insert_content="$INSERT_CONTENT" '{
    buffer[NR] = $0
    if (/app.migrations.add\(/) {
        last = NR
    }
} END {
    for (i = 1; i <= NR; i++) {
        print buffer[i]
        if (i == last) {
            print "    "insert_content
        }
    }
}' Sources/App/configure.swift > temp.swift

mv temp.swift Sources/App/configure.swift
