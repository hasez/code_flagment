#!/usr/bin/env bash
export PS4='\033[90m+${BASH_SOURCE##*/}:${LINENO}: ${FUNCNAME:+$FUNCNAME: }\033[0m'
set -Ceuxo pipefail
SCRIPT_DIR=$(
    cd "$(dirname "$0")"
    pwd
)

ymls=(
"./hoge/serverless.yml"
"./huga/serverless.yml"
)
for yml in "${ymls[@]}"; do
    echo "$yml"
    cd "$SCRIPT_DIR"
    cd "$(dirname "$yml")"
    pwd
    echo $ENV
    # sls deploy --stage ${ENV}  --verbose
done
