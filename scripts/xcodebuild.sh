#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ACTION="${1:-build}"
shift || true
SCHEME="${TEXTEND_XCODE_SCHEME:-TextendMessages}"

WORKTREE_NAME="$(basename "$ROOT_DIR")"
DERIVED_DATA_DIR="$ROOT_DIR/.codex-derived/$WORKTREE_NAME/DerivedData"
RESULTS_DIR="$ROOT_DIR/.codex-derived/$WORKTREE_NAME/Results"
LOGS_DIR="$ROOT_DIR/.codex-derived/$WORKTREE_NAME/Logs"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
RESULT_BUNDLE_PATH="$RESULTS_DIR/$ACTION-$TIMESTAMP.xcresult"
LOG_PATH="$LOGS_DIR/$ACTION-$TIMESTAMP.log"

mkdir -p "$DERIVED_DATA_DIR" "$RESULTS_DIR" "$LOGS_DIR"

"$ROOT_DIR/scripts/generate.sh"

set +e
xcodebuild \
  -project "$ROOT_DIR/Textend.xcodeproj" \
  -scheme "$SCHEME" \
  -configuration Debug \
  -derivedDataPath "$DERIVED_DATA_DIR" \
  -resultBundlePath "$RESULT_BUNDLE_PATH" \
  "$ACTION" \
  "$@" \
  2>&1 | tee "$LOG_PATH"
XCODE_STATUS=${PIPESTATUS[0]}
set -e

if [[ $XCODE_STATUS -ne 0 ]]; then
  echo "xcodebuild failed. Log: $LOG_PATH"
  exit "$XCODE_STATUS"
fi

echo "xcodebuild succeeded. Result bundle: $RESULT_BUNDLE_PATH"
