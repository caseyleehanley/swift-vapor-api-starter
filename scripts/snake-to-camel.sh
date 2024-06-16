#!/bin/bash

input="$1"

# Convert snake_case to camelCase
echo "$input" | awk 'BEGIN{FS="_"} {for(i=1;i<=NF;i++){ if(i==1) $i=tolower($i); else $i=toupper(substr($i,1,1)) tolower(substr($i,2)) } } 1' OFS=''