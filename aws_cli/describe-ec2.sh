# EC2 のインスタンスID と Name タグを取得
aws ec2 describe-instances \
  --query 'Reservations[*].Instances[*].[InstanceId,Tags[?Key==`Name`].Value]' \
  --output json | \
# [
#     [
#         [
#             "i-xxxxxxxxxxxxxxxxxxxx",
#             [
#                 "tag-name-value"
#             ]
#         ]
#     ],
# ]
jq -r '.[][]' | \
# [
#   "i-xxxxxxxxxxxxxxxxxxxx",
#   [
#     "tag-name-value"
#   ]
# ]
jq -r 'select(.[1] | length > 0) | .[0] + " " + .[1][0]' | \
# i-xxxxxxxxxxxxxxxxxxxx tag-name-value
sort -k 2
