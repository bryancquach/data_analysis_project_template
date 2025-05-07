#!/bin/bash

###################################################################################################
# Execute a bash command within a Docker container.
#
# Contributors:
#   Bryan Quach (bquach@rti.org)
#
# This script allows you to execute bash commands similar to a standard terminal session but within
# a Docker container of choice. This utility script was designed in response to an issue on the
# RTI Bio-research Machine sandbox server with file and directory permissions for some paths
# created within a Docker container. To change the permissions of these paths, root privileges are
# needed, which can only be obtained within a Docker container run as user 'root'.
###################################################################################################

###################################################################################################
# CONSTANT VARIABLES
###################################################################################################

readonly VERSION="0.0.1"

###################################################################################################
# FUNCTIONS
###################################################################################################

###################################################################################################
# Kill script and display a message.
# Globals:
#   None
# Arguments:
#   A message to STDERR.
# Outputs:
#   A message to STDERR.
# Returns:
#   Exit code 1.
###################################################################################################
die() {
  printf '%s\n' "$1" 1>&2
  exit 1
}

###################################################################################################
# Print usage documentation.
# Globals:
#   None
# Arguments:
#   None
# Outputs:
#   Writes usage documentation to STDOUT.
# Returns:
#   Default exit status of last command.
###################################################################################################
print_help() {
  echo
  echo "Execute a bash command within a Docker container."
  echo
  echo "Usage: bash docker_bash_quickrun.sh [options] docker_image \"bash_command\""
  echo
  echo "options:"
  echo "-h,--help                     Print this Help."
  echo "-V,--version                  Print script version."
  echo "-u,--user                     Host system username to use with Docker. Default: 'root'."
  echo "-g,--group                    Host system group name to use with Docker. Default: 'rti'."
  echo
  echo "positional arguments:"
  echo "docker_image                  Full name of Docker image or image ID."
  echo "bash_command                  Bash command to execute within a Docker container. NOTE: The"
  echo "                              command needs to be wrapped in double quotes with special"
  echo "                              symbols (e.g., \$) escaped if you do not want them to be"
  echo "                              expanded."
  echo
  echo "Your working directory must be within the git repository directory for this script to"
  echo "execute properly."
  echo
  echo
}

###################################################################################################
# MAIN PROGRAM
###################################################################################################

# Display help if no options are specified
if [ -z "$1" ]; then
  print_help
  exit
fi

# Set variable defaults
username=root
groupname=rti

# Template for parsing a variety of short and long option formats
while :; do
  case $1 in
    -h|-\?|--help) # display help
      print_help
      exit ;;
    -V|--version) # display version
      echo "Version ${VERSION}"
      exit ;;
    -u|--user) # take an option argument and ensure it has been specified
      if [ "$2" ]; then
        username=$2
        shift
      else
        die 'ERROR: "--user" requires a non-empty option argument.'
      fi ;;
    --user=?*) # delete everything up to "=" and assign the remainder.
      username=${1#*=} ;;
    --user=) # handle the case of an empty --file=
      die 'ERROR: "--user" requires a non-empty option argument.' ;;
    -g|--group) # take an option argument and ensure it has been specified
      if [ "$2" ]; then
        groupname=$2
        shift
      else
        die 'ERROR: "--group" requires a non-empty option argument.'
      fi ;;
    --group=?*) # delete everything up to "=" and assign the remainder.
      groupname=${1#*=} ;;
    --group=) # handle the case of an empty --file=
      die 'ERROR: "--group" requires a non-empty option argument.' ;;
    --) # end of all options
      shift
      break ;;
    -?*) # handle unknown option with a warning to STDERR
      printf 'WARN: Unknown option (ignored): %s\n' "$1" 1>&2 ;;
      # Alternative: throw an error and kill execution
      #error_msg=$(printf 'Error: Unknown option: %s\nUse -h to display usage.' "$1")
      #die "${error_msg}" ;;
    *) # default case of no more options so break out of the loop
      break
  esac
  shift
done

# Get Docker image name or ID
if [ -z "$1" ]; then
  die 'ERROR: positional argument "docker_image" is not specified.'
fi
docker_image="$1"
shift

# Get bash command to execute from within Docker container
if [ -z "$1" ]; then
  die 'ERROR: positional argument "bash_command" is not specified.'
fi
bash_command="$@"

# Get repository name
git_repo=$(echo $(git remote -v | head -1) | awk '{print $2}' | xargs basename)
git_repo=${git_repo/\.git/}
git_repo_host_dir=$(echo "$PWD" | sed -E 's/('"$git_repo"').+$/'"$git_repo"'/g')

# Update bash command to work from the $PWD equivalent within Docker
docker_pwd=$(echo "$PWD" | sed -E 's/^.+('"$git_repo"')/\/'"$git_repo"'/g')
bash_command="cd $docker_pwd; $bash_command"

# Convert user and group names into ID values
uid=$(id -u "$username")
gid=$(getent group "$groupname" | cut --delimiter ':' --fields 3)

# Start Docker container
echo
echo "Running the following command as user $uid and group $gid using Docker image $docker_image:"
echo -e "$bash_command\n"
docker run \
  --rm \
  -v "$git_repo_host_dir":/"$git_repo" \
  --cpus 1 \
  --memory 1g \
  -u "$uid":"$gid" \
  -t "$docker_image" \
  /bin/bash -c "$bash_command"
