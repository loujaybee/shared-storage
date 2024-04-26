#!/bin/sh

SHARED_FOLDER="$GITPOD_REPO_ROOT/shared"

# Function to move a directory and replace it with a symlink
move_and_link() {
    local folder_name=$1
    local old_base_dir=$2
    local old_dir="${old_base_dir}/${folder_name}"
    local new_dir="${SHARED_FOLDER}/${folder_name}"

    if [ -L "$old_dir" ]; then
        echo "$old_dir is a symlink already" 
    elif [ -d "$old_dir" ]; then
        echo "moving $old_dir to $new_dir and replacing it with a symlink" 
        mv "$old_dir" "$new_dir"
        ln -s "$new_dir" "$old_dir"
    else 
        echo "creating new symlink from $old_dir to $new_dir"
        mkdir -p "$old_base_dir"
        ln -s "$new_dir" "$old_dir"
    fi
}

move_and_link secretsauce /workspace/m2-repository/com/mycompany