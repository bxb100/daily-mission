#!/usr/bin/env bash
set -u

ENV_FILE=".env"
MIN_LENGTH=8

# 1. 预处理输入文件列表
# 我们需要过滤掉已被删除的文件（git hook 可能会传入已删除的文件名）
TARGET_FILES=()
for file in "$@"; do
    if [ -f "$file" ]; then
        TARGET_FILES+=("$file")
    fi
done

# 如果没有需要扫描的文件，直接退出
if [ ${#TARGET_FILES[@]} -eq 0 ]; then
    exit 0
fi

if [ ! -f "$ENV_FILE" ]; then
    exit 0
fi

EXIT_CODE=0
RED='\033[0;31m'
NC='\033[0m'

# 2. 遍历 .env 中的 Secrets
while IFS='=' read -r key value; do
    # 清理 Key/Value (逻辑同上)
    key=${key#"export "}
    value=${value%%#*}
    value=${value%\"}
    value=${value#\"}
    value=${value%\'}
    value=${value#\'}
    value=$(echo "$value" | xargs)
    key=$(echo "$key" | xargs)

    if [ -z "$value" ] || [ ${#value} -lt $MIN_LENGTH ]; then
        continue
    fi

    # 3. 针对目标文件列表执行搜索
    # 这里的关键点是直接将 "${TARGET_FILES[@]}" 传给 rg
    # -F: Fixed strings (字面量)
    # -l: 只输出匹配的文件名
    MATCHED_FILES=$(rg --fixed-strings -l "$value" "${TARGET_FILES[@]}")

    if [ -n "$MATCHED_FILES" ]; then
        echo -e "${RED}[ERROR]${NC} Secret leak detected for key: ${RED}${key}${NC}"
        echo "       The value matches content in the following staged files:"

        # 格式化输出文件名
        while IFS= read -r match; do
            echo "         - $match"
        done <<< "$MATCHED_FILES"

        EXIT_CODE=1
    fi

done < <(grep -v '^#' "$ENV_FILE" | grep -v '^$')

exit $EXIT_CODE
