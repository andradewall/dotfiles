artisan() {
    # ---------------------------------------------------------
    # 1. Flexible File Detection
    # ---------------------------------------------------------
    # Look for any file matching *compose*.y*ml
    # (N) = null glob (prevents error if no match)
    # (.) = only regular files
    # [1] = takes the first match found
    local compose_file=( *compose*.y*ml(N.) )

    if (( ${#compose_file} == 0 )); then
        echo "❌ Error: No compose file (*compose*.y*ml) found in this folder."
        return 1
    fi

    # Pick the first file found (e.g., compose.dev.yaml)
    local target_file="${compose_file[1]}"

    # ---------------------------------------------------------
    # 2. Determine Command Arguments
    # ---------------------------------------------------------
    # If the file is NOT a standard name, we must force Docker to use it with -f
    # Standard names: docker-compose.yml, docker-compose.yaml, compose.yml, compose.yaml
    local docker_cmd="docker compose"
    
    if [[ ! "$target_file" =~ ^(docker-compose\.ya?ml|compose\.ya?ml)$ ]]; then
        # It's a custom name (like compose.dev.yaml), so we force the -f flag
        docker_cmd="docker compose -f $target_file"
    fi

    # ---------------------------------------------------------
    # 3. Find the PHP Service
    # ---------------------------------------------------------
    # We use the constructed $docker_cmd to ensure we query the correct file
    local service=$($docker_cmd ps --services --filter "status=running" | grep -E '^(app|php|laravel\.test|workspace|web)$' | head -n 1)

    if [ -z "$service" ]; then
        echo "❌ Error: Could not detect a running PHP service in '$target_file'."
        return 1
    fi

    # ---------------------------------------------------------
    # 4. Execute
    # ---------------------------------------------------------
    echo -e "\e[2m🐳 Using file: $target_file | Container: $service\e[0m"
    # eval is needed here to properly handle the spaces in docker_cmd
    eval "$docker_cmd exec -it $service php artisan \"$@\""
}
