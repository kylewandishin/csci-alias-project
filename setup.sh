#!/bin/bash
# Path to new.sh
new_sh="/home/jovyan/.bashrc"
# Check if new.sh exists
touch "$new_sh"  # Create new.sh if it doesn't exist
> "$new_sh"
# Append the contents of /home/jovyan/.csci-alias/aliases.sh to new.sh
cat /home/jovyan/csci-alias-project/template >> "$new_sh"
