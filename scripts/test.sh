#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

swift test
"$ROOT_DIR/scripts/build.sh"
TEXTEND_XCODE_SCHEME=TextendHarness "$ROOT_DIR/scripts/build.sh"
