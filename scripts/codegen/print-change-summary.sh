#!/bin/bash

schema=$1
snake_case=$2
PascalCase=$3
camelCase=$4

printf "\nChange Summary (not yet saved):\n"
printf "\nSchema Name:\t%s" $schema
printf "\nModel Name:\t%s" $PascalCase
printf "\nLocal Variable:\t$camelCase"
printf "\n\nFiles to Add:"
printf "\n \033[32m[+] Sources/App/Migrations/Create%s.swift\033[0m" $PascalCase
printf "\n \033[32m[+] Sources/App/Resources/%s.swift\033[0m" $PascalCase
printf "\n \033[32m[+] Sources/App/Models/%sModel.swift\033[0m" $PascalCase
printf "\n \033[32m[+] Sources/App/Models/%sModel+Queryable.swift\033[0m" $PascalCase
printf "\n \033[32m[+] Sources/App/Middleware/%sModelMiddleware.swift\033[0m" $PascalCase
printf "\n \033[32m[+] Sources/App/DTOs/%sDTOs.swift\033[0m" $PascalCase
printf "\n \033[32m[+] Sources/App/Controllers/%sController.swift\033[0m" $PascalCase
printf "\n \033[32m[+] Tests/ControllerTests/API/V1/%sControllerTests.swift\033[0m" $PascalCase
printf "\n \033[32m[+] Tests/ModelTests/%sModelTests.swift\033[0m" $PascalCase
printf "\n \033[32m[+] Tests/DTOTests/%sDTOTests.swift\033[0m" $PascalCase
printf "\n \033[32m[+] Tests/Support/Factories/%sFactories.swift\033[0m" $PascalCase
printf "\n\nFiles to Modify:"
printf "\n \033[36m[~] Sources/App/configure.swift\033[0m"
printf "\n \033[36m[~] Sources/App/routes.swift\033[0m"
printf "\n\n"

read -p "Continue? (y/n): " choice; \
if [ $choice != "y" ]; then \
	printf "Aborting."; \
	exit 1; \
fi

printf "\n"
colors=(
	"\033[31m"  # Red
	"\033[32m"  # Green
	"\033[33m"  # Yellow
	"\033[34m"  # Blue
	"\033[35m"  # Magenta
	"\033[36m"  # Cyan
)

word="[ Writing Code"

end_time=$((SECONDS + 2))
i=0
while [ $SECONDS -lt $end_time ]; do
	for color in "${colors[@]}"; do
		if (( i % 3 == 0 )); then \
			word="${word}."; \
		fi
		echo -ne "${color}${word} ]\033[0m\r"
		sleep 0.1
		((i++))
	done
done

printf "\n"