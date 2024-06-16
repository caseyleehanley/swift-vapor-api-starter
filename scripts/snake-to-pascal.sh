#!/bin/bash

input="$1"

# Convert snake_case to PascalCase
echo "$input" | awk 'BEGIN{FS=OFS="_"} {for(i=1;i<=NF;i++){$i=toupper(substr($i,1,1)) tolower(substr($i,2))}}1' OFS=