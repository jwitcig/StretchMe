#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

"$ROOT_DIR/scripts/xcodebuild.sh" build \
  -sdk iphonesimulator \
  CODE_SIGNING_ALLOWED=NO
