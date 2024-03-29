#!/usr/bin/env bash
###
# Remove files automatically generated by Mac.
# - ._*
# - .DS_Store
###
export PS4='\033[90m+${BASH_SOURCE##*/}:${LINENO}: ${FUNCNAME:+$FUNCNAME: }\033[0m'
set -Ceuxo pipefail
SCRIPT_DIR=$(
    cd "$(dirname "$0")"
    pwd
)

# settings target directories
directorys=(
   "directory one"
   "directory second"
   "directory third"
)

for directory in "${directorys[@]}"
do
    # eval cd $directory;pwd
    eval find $directory -name "._*"        -delete -print
    eval find $directory -name ".DS_Store"  -delete -print
done
