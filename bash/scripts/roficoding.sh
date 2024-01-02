#!/usr/bin/env bash

# Path to your "coding" folder
coding_folder="$HOME/coding"

# Get the list of projects
projects=($(find "$coding_folder" -maxdepth 1 -type d -exec basename {} \;))

# Display Rofi menu and get user selection
selected_project=$(for project in "${projects[@]}"; do echo "$project"; done | rofi -dmenu -p -theme config)

# If user selected a project, proceed
if [ -n "$selected_project" ]; then
    # Set the project path
    project_path="$coding_folder/$selected_project"
    # Check if tmux server is running if not start a server
if ! tmux has-session 2>/dev/null; then
        tmux new-session -d -s coding
    fi

    # Check if the commands.txt file exists in the project
    commands_file="$project_path/commands.txt"
    if [ -e "$commands_file" ]; then
        # Read commands from the file
        readarray -t commands < "$commands_file"
    else
        # Default to a generic command if commands.txt doesn't exist
        commands=("")
    fi

    # Create a new tmux window named after the project
    tmux new-window -n "$selected_project" -c "$project_path"

    # Launch nvim with predefined buffers and commands
    tmux send-keys -t "$selected_project" "nvim" C-m
    tmux send-keys -t "$selected_project" ":vsp" C-m

    # Loop through commands and send them to nvim
    for command in "${commands[@]}"; do
        tmux send-keys -t "$selected_project" ":term $command" C-m
        tmux send-keys -t "$selected_project" ":vsp" C-m
    done
fi
