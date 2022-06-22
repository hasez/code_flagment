#!/usr/bin/env bash
export PS4='\033[90m+${BASH_SOURCE##*/}:${LINENO}: ${FUNCNAME:+$FUNCNAME: }\033[0m'
set -Ceuxo pipefail
SCRIPT_DIR=$(
    cd "$(dirname "$0")"
    pwd
)

#######
# paramter analysis
#######
DONE_FILE_PATH=""
param=()
for OPT in "$@"; do
    case $OPT in
    -h | --help)
        usage
        exit 0
        ;;
    -f | --file)
        if [[ -z "${2:-}" ]] || [[ "${2}" =~ ^-+ ]]; then
            echo "ERROR: '${OPT}' option requires an argument."
            usage
            exit 1
        fi
        DONE_FILE_PATH="${2}"
        shift 2
        ;;
    -- | -)
        shift 1
        param+=("$@")
        break
        ;;
    -*)
        echo "ERROR: Unknown option '${OPT}'"
        usage
        exit 1
        ;;
    *)
        if [[ -n "${1:-}" ]] && [[ ! "${1}" =~ ^-+ ]]; then
            param+=("${1}")
            shift 1
        fi
        ;;
    esac
done

if [[ ${#param[@]} != 2 ]]; then
    echo "ERROR: Invalid number of arguments."
    usage
    exit 1
fi

# 引数取得
SUBCOMMAND=${param[0]}
KEY=${param[1]}
