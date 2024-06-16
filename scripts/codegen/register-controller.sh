#!/bin/bash

# Register controller in `Sources/App/routes.swift`

INSERT_CONTENT=$(cat Templates/Sources/App/routes.swift)
INSERT_CONTENT=$(echo $INSERT_CONTENT | sed "s/<#Entity#>/$3/g")
INSERT_CONTENT=$(echo $INSERT_CONTENT | sed "s/<#entities#>/$1/g")
INSERT_CONTENT=$(echo $INSERT_CONTENT | sed "s/<#entity#>/$4/g")

awk -v insert_content="$INSERT_CONTENT" '{
	buffer[NR] = $0
	if (/try v1.register\(collection:/) {
		last = NR
	}
} END {
	for (i = 1; i <= NR; i++) {
		print buffer[i]
		if (i == last) {
			print "		"insert_content
		}
	}
}' Sources/App/routes.swift > temp.swift

mv temp.swift Sources/App/routes.swift
