#!/usr/bin/env bash
# `12_code_quality.md`: very_good_analysis çok sayıda info üretebilir; önce uyarı/hata fatal.
set -euo pipefail
cd "$(dirname "$0")/.."
exec flutter analyze --no-fatal-infos "$@"
