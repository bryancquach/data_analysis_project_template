#!/bin/bash
#SBATCH --job-name=<JOB NAME> 
#SBATCH --partition=<SLURM PARTITION NAME>
#SBATCH --mem=<MAX REQUIRED RAM IN GIGABYTES>gb
#SBATCH --time=<D>-<HH>:<MM>:<SS>
#SBATCH -o <PATH TO OUTPUT DIR>/<FILENAME PREFIX>.out

###################################################################################################
# One sentence short description.
#
# Longer summary.
#
# Example usage:
# sbatch path/to/script/script_name.sh
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

# Code not executed within a container here
echo "lorem ipsum"

# Code executed within a Docker container here
docker_image="" #Docker image name and tag
docker run \
  --rm \
  -v "${git_repo_host_dir}":/"${git_repo}" \
  --cpus <NUMBER OF CPUs> \
  --memory <MAX RAM NEEDED IN GIGABYTES>g \
  -t "${docker_image}" \
  <COMMAND TO RUN INSIDE CONTAINER>

# Code executed within an Apptainer container here
sif="" #relative path and name of SIF container file 
singularity exec \
  --bind ./:/${repo_name} \
  ${sif} \
  <COMMAND TO RUN INSIDE CONTAINER>
