#!/bin/bash

# Attempt to singularize the input string by replacing a suffix substring

# This does not cover all cases, as the English lanuguage contains a
# lot of edge cases, but it does attempt to capture the most common cases.

input="$1"

if [[ "$input" =~ .*ies$ ]]; then
  input="${input%ies}y" # e.g., butterflies -> butterfly
elif [[ "$input" =~ .*oes$ ]]; then
  input="${input%oes}o" # e.g., potatoes -> potato
elif [[ "$input" =~ .*sses$ ]]; then
  input="${input%ses}s" # e.g., bosses -> boss
elif [[ "$input" =~ .*xes$ ]]; then
  input="${input%xes}x" # e.g., faxes -> fax
elif [[ "$input" =~ .*ches$ ]]; then
  input="${input%ches}ch" # e.g., bunches -> bunch
elif [[ "$input" =~ .*shes$ ]]; then
  input="${input%shes}sh" # e.g., flashes -> flash
elif [[ "$input" =~ .*s$ ]]; then
  input="${input%s}" # e.g., things -> thing
fi

echo "$input"