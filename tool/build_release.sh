#!/usr/bin/env bash
# Üretim derlemesi — kod karıştırma ve ayrı sembol dizini (`15_security.md`).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
mkdir -p build/debug-info
flutter build apk --release --obfuscate --split-debug-info=build/debug-info "$@"
