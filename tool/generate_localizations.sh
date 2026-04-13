#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "==> Export ARB dosyaları (language_constants)"
dart run tool/export_l10n_arbs.dart

gen_one() {
  local arb_dir="$1"
  local template="$2"
  local out_file="$3"
  local out_class="$4"
  local out_dir="$5"
  flutter gen-l10n \
    --arb-dir="$arb_dir" \
    --template-arb-file="$template" \
    --output-localization-file="$out_file" \
    --output-class="$out_class" \
    --nullable-getter \
    --output-dir="$out_dir"
}

echo "==> App (core)"
gen_one lib/core/l10n/arb app_en.arb app_localizations.dart AppLocalizations lib/core/l10n/generated

echo "==> Home"
gen_one lib/features/home/l10n home_en.arb home_localizations.dart HomeLocalizations lib/features/home/l10n/generated

echo "==> Draw"
gen_one lib/features/draw/l10n draw_en.arb draw_localizations.dart DrawLocalizations lib/features/draw/l10n/generated

echo "==> Shapes"
gen_one lib/features/shapes/l10n shapes_en.arb shapes_localizations.dart ShapesLocalizations lib/features/shapes/l10n/generated

echo "==> Info"
gen_one lib/features/info/l10n info_en.arb info_localizations.dart InfoLocalizations lib/features/info/l10n/generated

echo "==> home_string_lookup.dart"
dart run tool/export_home_string_lookup.dart

dart format lib/core/l10n/generated lib/features/home/l10n/generated lib/features/draw/l10n/generated lib/features/shapes/l10n/generated lib/features/info/l10n/generated lib/features/home/l10n/home_string_lookup.dart

echo "Tamam."
