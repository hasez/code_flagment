#!/usr/bin/env bash

USER_NAME="YOUR_NAME"
KEYWORD="KEYWORD" # ex) "feature/"

# git ディレクトリ一覧を作成
# expect <Organization>/<Repository>
find . -maxdepth 2 -mindepth 2 -type d > directory.lst

# 自分が作成したリモートブランチを取得して、削除する
while read -r dir; do
    echo "$dir"
    git -C "$dir" fetch --all --prune --quiet
    git -C "$dir" for-each-ref --format='%(refname:short) %(authorname) %(committerdate:relative)' refs/remotes/origin \
        | grep $USER_NAME | grep $KEYWORD \
        | awk '{print $1}' | sed 's/origin\///'
done < directory.lst > branch-myself-removed-before.lst 2>&1

while read -r dir; do
    echo "$dir"
    git -C "$dir" fetch --all --prune --quiet
    git -C "$dir" for-each-ref --format='%(refname:short) %(authorname) %(committerdate:relative)' refs/remotes/origin \
        | grep $USER_NAME | grep $KEYWORD \
        | awk '{print $1}' | sed 's/origin\///' \
        | xargs -I {} git -C "$dir" push origin --delete {}
done < directory.lst > branch-myself-removed.lst 2>&1

while read -r dir; do
    echo "$dir"
    git -C "$dir" fetch --all --prune --quiet
    git -C "$dir" for-each-ref --format='%(refname:short) %(authorname) %(committerdate:relative)' refs/remotes/origin \
        | grep $USER_NAME | grep $KEYWORD \
        | awk '{print $1}' | sed 's/origin\///'
done < directory.lst > branch-myself-removed-after.lst 2>&1

# マージ済みのリモートブランチを取得して、削除する
while read -r dir; do
    echo "$dir"
    git -C "$dir" fetch --all --prune --quiet
    git -C "$dir" branch -r --merged \
        | grep $KEYWORD \
        | awk '{print $1}' | sed 's/origin\///'
done < directory.lst > branch--merged-before.lst

while read -r dir; do
    echo "$dir"
    git -C "$dir" fetch --all --prune --quiet
    git -C "$dir" branch -r --merged \
        | grep $KEYWORD \
        | awk '{print $1}' | sed 's/origin\//\t/' \
        | xargs -I {} git push origin --delete {}
done < directory.lst > branch--merged.lst

while read -r dir; do
    echo "$dir"
    git -C "$dir" fetch --all --prune --quiet
    git -C "$dir" branch -r --merged \
        | grep $KEYWORD \
        | awk '{print $1}' | sed 's/origin\///'
done < directory.lst > branch--merged-after.lst
