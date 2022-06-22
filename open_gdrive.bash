#!/usr/bin/env bash

##################
# Windows の Google Drive のパスを Mac の Google Drive のパスに置き換えて、開きます
# $1 WindowsのGドライブのパス
##################
function gdrive {
    local win_path="$1"
    if [ -z "$win_path" ]; then
        echo "required parameter missing"; return
    fi
    local mac_path=""
    win_mydrive='G:\マイドライブ'
    win_shareddrive='G:\共有ドライブ'
    case "$win_path" in
        $win_mydrive*)
            search=$win_mydrive
            replace='/Volumes/GoogleDrive/My Drive'
            ;;
        $win_shareddrive*)
            search=$win_shareddrive
            replace='/Volumes/GoogleDrive/Shared drives'
            ;;
        *)
            echo "unsupported path: $win_path"; return
            ;;
    esac
    mac_path=${win_path/$search/$replace}
    # \ を / に置換
    mac_path=${mac_path//\\//}
    open "$mac_path"
}
