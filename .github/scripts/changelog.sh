#!/usr/bin/env bash
# 根据 git 提交历史生成一个版本的更新日志段落，输出到 stdout
# 用法: changelog.sh <版本号>
# 提交信息按 conventional commit 前缀归类，例如:
#   feat: 添加设置页面        -> 新功能
#   fix: 修复进度跳变          -> 修复
#   其它任意写法               -> 其它
set -euo pipefail

VERSION="${1:?用法: changelog.sh <版本号>}"

# 切到仓库根目录，保证从任意 cwd 调用都能读到完整提交历史
cd "$(git -C "$(dirname "${BASH_SOURCE[0]}")" rev-parse --show-toplevel)"

# 上一个 tag 到当前 HEAD 的范围；首次发版（无 tag）则取全部历史
PREV_TAG="$(git describe --tags --abbrev=0 HEAD^ 2>/dev/null || true)"
RANGE="${PREV_TAG:+${PREV_TAG}..HEAD}"

# 去掉 "feat(scope): " / "fix!: " 之类的前缀，只留描述
strip_prefix() {
  sed -E 's/^[a-z]+(\([^)]*\))?!?:[[:space:]]*//'
}

# shellcheck disable=SC2086  # RANGE 为空时需要展开成无参数
subjects() { git log ${RANGE} --no-merges --pretty=format:'%s'; }

FEATS="$(subjects | grep -E '^feat' | strip_prefix || true)"
FIXES="$(subjects | grep -E '^fix' | strip_prefix || true)"
OTHERS="$(subjects | grep -Ev '^(feat|fix)' | strip_prefix || true)"

emit_section() {
  local title="$1" body="$2"
  [ -z "$body" ] && return 0
  echo "### $title"
  echo "$body" | sed 's/^/- /'
  echo
}

echo "## [$VERSION] - $(date +%Y-%m-%d)"
echo
emit_section "✨ 新功能" "$FEATS"
emit_section "🐛 修复" "$FIXES"
emit_section "🔧 其它" "$OTHERS"
