#!/bin/sh

for row in $(jq -r '.[] | @base64' "$1"); do
    # https://www.starkandwayne.com/blog/bash-for-loop-over-json-array-using-jq/index.html
    config=$(echo "${row}" | base64 --decode)
    task=$(echo "$config" | jq -r '.task_name')

    echo "$config" | tg-signer --log-file tg-signer.log import "$task"
    tg-signer --log-file tg-signer.log run-once "$task" >/dev/null 2>&1
done
