#!/usr/bin/env bash

## Description
# AWS Scheduler のスケジュールの開始日時を変更して、定期実行のスクリプトをスキップする

export AWS_PROFILE=your-profile-name

##### ここを変更する 指定した日時までのスケジュールをスキップ

set_start_date_jst="2024-08-05T00:00:00+09:00" # JST

#####

# convert to UTC for GNU 通常はこちら
# set_start_date_utc=$(date -u -d "$set_start_date_jst" "+%Y-%m-%dT%H:%M:%S%:z")
# convert to UTC for BSD MacOS
set_start_date_utc=$(gdate -u -d "$set_start_date_jst" "+%Y-%m-%dT%H:%M:%S%:z")

function get_schedule {
  local _my_schedule_name=$1
  local _my_group_name=$2
  aws scheduler get-schedule --name "$_my_schedule_name" --group-name "$_my_group_name"
}

function update_start_date {
  local _my_schedule_name=$1
  local _my_group_name=$2

  before=$(get_schedule "$_my_schedule_name" "$_my_group_name")

  # start_date 以外の項目は変更しない
  before_escape=$(echo "$before" | jq '@json' | jq -r '.')
  description=$(echo "$before" | jq -r '.Description')
  flexible_time_window=$(echo "$before" | jq -r '.FlexibleTimeWindow')
  schedule_expression=$(echo "$before" | jq -r '.ScheduleExpression')
  schedule_expression_timezone=$(echo "$before" | jq -r '.ScheduleExpressionTimezone')
  target=$(echo "$before" | jq -r '.Target')

  aws scheduler update-schedule --name "$_my_schedule_name" --group-name "$_my_group_name" \
      --start-date "$set_start_date_utc" \
      --flexible-time-window "$flexible_time_window" --schedule-expression "$schedule_expression" --target "$target" \
      --schedule-expression-timezone "$schedule_expression_timezone" --description "$description"

  after=$(get_schedule "$_my_schedule_name" "$_my_group_name")

  # expected: changed only StartDate (and LastModificationDate). 
  diff <(echo "$before") <(echo "$after")
}

update_start_date my_schedule_name my_group_name
