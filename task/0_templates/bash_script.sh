#!/bin/bash

###################################################################################################
# One sentence short description.
#
# Longer summary. 
#
# Example usage:
# bash path/to/script/script_name.sh 
#
# Contributors:
#   * First and last name (email address)
###################################################################################################

# Declare global variables

# Repository name
git_repo=$(echo $(git remote -v | head -1) | awk '{print $2}' | xargs basename)
git_repo=${git_repo/\.git/}

# Absolute path to repo base directory
git_repo_host_dir=$(echo "$PWD" | sed -E 's/('"$git_repo"').+$/'"$git_repo"'/g')

# Check that working directory is the repo base directory
if [ $(basename $(pwd)) != "${git_repo}" ]; then
  echo "Warning: script should execute from repo base directory"
  echo "Switching to repo base directory ${git_repo_host_dir}"
  cd ${git_repo_host_dir}
fi

# Other code
