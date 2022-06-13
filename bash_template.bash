#!/usr/bin/env bash
export PS4='\033[90m+${BASH_SOURCE##*/}:${LINENO}: ${FUNCNAME:+$FUNCNAME: }\033[0m'
set -Ceuxo pipefail
SCRIPT_DIR=$(
    cd "$(dirname "$0")"
    pwd
)
