wk() {
    # ---------------------------------------------------------
    # 1. Smart File Selection (Priority: Dev > Standard)
    # ---------------------------------------------------------
    
    # Find ALL match candidates into an array
    local files=( *compose*.y*ml(N.) )

    if (( ${#files} == 0 )); then
        echo "❌ Error: No compose file (*compose*.y*ml) found."
        return 1
    fi

    local target_file=""

    # Check for a file containing "dev" (e.g., compose.dev.yaml)
    # ${(M)...} filters the array for matches containing "dev"
    local dev_candidates=( ${(M)files:#*dev*} )

    if (( ${#dev_candidates} > 0 )); then
        # Priority A: Use the first "dev" file found
        target_file="${dev_candidates[1]}"
    else
        # Priority B: No dev file? Just take the first file found
        target_file="${files[1]}"
    fi

    # ---------------------------------------------------------
    # 2. Determine Command Arguments
    # ---------------------------------------------------------
    local docker_cmd="docker compose"
    
    # If filename is non-standard, we MUST use the -f flag
    if [[ ! "$target_file" =~ ^(docker-compose\.ya?ml|compose\.ya?ml)$ ]]; then
        docker_cmd="docker compose -f $target_file"
    fi

    # ---------------------------------------------------------
    # 3. Find the PHP Service
    # ---------------------------------------------------------
    # We use the constructed $docker_cmd to query the specific file
    local service=$(eval "$docker_cmd ps --services --filter 'status=running'" | grep -E '^(workspace)$' | head -n 1)

    if [ -z "$service" ]; then
        echo "❌ Error: Could not detect a running PHP service in '$target_file'."
        return 1
    fi

    # ---------------------------------------------------------
    # 4. Execute
    # ---------------------------------------------------------
    echo -e "\e[2m🐳 Using file: $target_file | Container: $service | Command: $docker_cmd exec -it $service $@\e[0m"
    eval "$docker_cmd exec -it $service $@"
}
