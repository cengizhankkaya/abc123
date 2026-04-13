// Generates feature ARB files from `language_constants.dart` maps.
// Run from repo root: dart run tool/export_l10n_arbs.dart
//
// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:io';

import 'package:abc123/core/constants/language_constants.dart';

import 'l10n_export_seed.dart';

const _drawOnlyKeys = {
  'drawNumberInstruction',
  'drawAnyNumberInstruction',
  'watchAdToUnlock',
};

String _localeCode(AppLanguage l) => switch (l) {
      AppLanguage.turkish => 'tr',
      AppLanguage.english => 'en',
      AppLanguage.chinese => 'zh',
      AppLanguage.spanish => 'es',
      AppLanguage.hindi => 'hi',
      AppLanguage.french => 'fr',
      AppLanguage.arabic => 'ar',
      AppLanguage.portuguese => 'pt',
      AppLanguage.bengali => 'bn',
      AppLanguage.russian => 'ru',
      AppLanguage.urdu => 'ur',
      AppLanguage.azerbaijani => 'az',
      AppLanguage.german => 'de',
    };

String _templateFromTwoIntFn(Object? fn) {
  final s = (fn as dynamic)(99, 88) as String;
  return s.replaceAll('99', '{correct}').replaceAll('88', '{total}');
}

Map<String, dynamic>? _metaForValue(String key, String value) {
  final re = RegExp(r'\{(\w+)\}');
  final names = re.allMatches(value).map((m) => m.group(1)!).toSet();
  if (names.isEmpty) {
    return {'description': 'l10n: $key'};
  }
  final ph = <String, dynamic>{};
  for (final n in names) {
    final isInt = n == 'amount' ||
        n == 'count' ||
        n == 'price' ||
        n == 'correct' ||
        n == 'total';
    ph[n] = isInt
        ? {'type': 'int', 'example': '1'}
        : {'type': 'String', 'example': n};
  }
  return {'description': 'l10n: $key', 'placeholders': ph};
}

void _writeArbDir({
  required String bundlePrefix,
  required String dir,
  required Map<AppLanguage, Map<String, String>> byLang,
}) {
  final d = Directory(dir);
  if (!d.existsSync()) {
    d.createSync(recursive: true);
  }
  for (final lang in AppLanguage.values) {
    final code = _localeCode(lang);
    final entries = byLang[lang]!;
    final root = <String, dynamic>{'@@locale': code};
    for (final e in entries.entries) {
      root[e.key] = e.value;
      final meta = _metaForValue(e.key, e.value);
      if (meta != null) {
        root['@${e.key}'] = meta;
      }
    }
    final path = '$dir/${bundlePrefix}_$code.arb';
    File(path).writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(root),
    );
    stdout.writeln('Wrote $path (${entries.length} keys)');
  }
}

Map<String, String> _homeForLang(AppLanguage lang) {
  final out = <String, String>{};
  String pick(Map<AppLanguage, String> m) =>
      m[lang] ?? m[AppLanguage.english]!;

  for (final e in localizedTexts.entries) {
    if (_drawOnlyKeys.contains(e.key)) {
      continue;
    }
    out[e.key] = pick(e.value);
  }
  final tool = localizedToolControlPanelTexts[lang] ??
      localizedToolControlPanelTexts[AppLanguage.english]!;
  out['numbersTitle'] = tool['numberTitle']! as String;
  out['lettersTitle'] = tool['letterTitle']! as String;
  out['shapesTitle'] = tool['shapeTitle']! as String;
  out['noBadgesFound'] = lang == AppLanguage.turkish
      ? 'Rozet bulunamadı'
      : 'No badges found';
  return out;
}

Map<String, String> _drawForLang(AppLanguage lang) {
  final out = <String, String>{};
  String pick(Map<AppLanguage, String> m) =>
      m[lang] ?? m[AppLanguage.english]!;

  for (final k in _drawOnlyKeys) {
    out[k] = pick(localizedTexts[k]!);
  }

  final action = localizedActionToolbarTexts[lang] ??
      localizedActionToolbarTexts[AppLanguage.english]!;
  out['drawSequentialMode'] = action['sequentialMode']! as String;
  out['drawCorrectTotal'] =
      _templateFromTwoIntFn(action['correctTotal'] as Object?);
  out['drawClear'] = action['clear']! as String;
  out['drawPen'] = action['pen']! as String;
  out['drawEraser'] = action['eraser']! as String;
  out['drawRecognize'] = action['recognize']! as String;

  final tool = localizedToolControlPanelTexts[lang] ??
      localizedToolControlPanelTexts[AppLanguage.english]!;
  out['drawPenColor'] = tool['penColor']! as String;
  out['drawNumberSectionTitle'] = tool['numberTitle']! as String;
  out['drawLetterSectionTitle'] = tool['letterTitle']! as String;
  out['drawShapeSectionTitle'] = tool['shapeTitle']! as String;

  // Migrated from core app ARB (balloon + letter puzzle)
  const letterEn = 'Preparing puzzle…';
  const letterTr = 'Puzzle hazırlanıyor…';
  out['drawLetterPuzzlePreparing'] = switch (lang) {
    AppLanguage.turkish => letterTr,
    AppLanguage.english => letterEn,
    _ => letterEn,
  };
  const pausedEn = 'GAME PAUSED';
  const pausedTr = 'OYUN DURAKLATILDI';
  out['drawGamePausedTitle'] = lang == AppLanguage.turkish ? pausedTr : pausedEn;
  out['drawContinue'] = lang == AppLanguage.turkish ? 'Devam Et' : 'Continue';
  out['drawStartGame'] =
      lang == AppLanguage.turkish ? 'OYUNU BAŞLAT' : 'START GAME';
  out['drawBalloonReady'] = lang == AppLanguage.turkish
      ? '{count} adet balonla oynamaya hazır mısın?'
      : 'Ready to play with {count} balloons?';
  out['drawBalloonScoreHint'] = lang == AppLanguage.turkish
      ? 'Balonları patlatarak puan kazan!\nNe kadar küçük balon patlatırsan o kadar çok puan alırsın.'
      : 'Pop balloons to earn points!\nThe smaller the balloon, the more points you get.';

  // Erişilebilirlik (ekran okuyucu): TR ayrı, diğer tüm diller İngilizce şablon.
  final isTr = lang == AppLanguage.turkish;
  String a11y({required String en, required String tr}) => isTr ? tr : en;
  out['drawSemanticMute'] = a11y(en: 'Mute sounds', tr: 'Sesi kapat');
  out['drawSemanticUnmute'] = a11y(en: 'Unmute sounds', tr: 'Sesi aç');
  out['drawSemanticDrawingCanvas'] = a11y(
    en: 'Drawing area. Draw with your finger.',
    tr: 'Çizim alanı. Parmağınla çiz.',
  );
  out['drawSemanticPauseGame'] = a11y(en: 'Pause game', tr: 'Oyunu duraklat');
  out['drawSemanticResumeGame'] = a11y(en: 'Resume game', tr: 'Oyuna devam et');
  out['drawSemanticPenColorBlack'] =
      a11y(en: 'Black pen color', tr: 'Siyah kalem rengi');
  out['drawSemanticPenColorRed'] =
      a11y(en: 'Red pen color', tr: 'Kırmızı kalem rengi');
  out['drawSemanticPenColorBlue'] =
      a11y(en: 'Blue pen color', tr: 'Mavi kalem rengi');
  out['drawSemanticPenColorYellow'] =
      a11y(en: 'Yellow pen color', tr: 'Sarı kalem rengi');
  out['drawSemanticPenColorGreen'] =
      a11y(en: 'Green pen color', tr: 'Yeşil kalem rengi');
  out['drawSemanticPenColorPurple'] =
      a11y(en: 'Purple pen color', tr: 'Mor kalem rengi');
  out['drawSemanticPenColorOrange'] =
      a11y(en: 'Orange pen color', tr: 'Turuncu kalem rengi');

  return out;
}

Map<String, String> _shapesForLang(AppLanguage lang) {
  final m = localizedShapeNames[lang] ??
      localizedShapeNames[AppLanguage.english]!;
  return {
    'shapeDaire': m['DAIRE']!,
    'shapeKare': m['KARE']!,
    'shapeUcgen': m['ÜÇGEN']!,
  };
}

Map<String, String> _infoMergedForLang(AppLanguage lang) {
  final out = <String, String>{};
  final info = localizedInfoScreenTexts[lang] ??
      localizedInfoScreenTexts[AppLanguage.english]!;
  for (final e in info.entries) {
    out['info${e.key[0].toUpperCase()}${e.key.substring(1)}'] = e.value as String;
  }
  final res = localizedResultScreenTexts[lang] ??
      localizedResultScreenTexts[AppLanguage.english]!;
  for (final e in res.entries) {
    if (e.key == 'progress') {
      out['resultProgress'] = _templateFromTwoIntFn(e.value);
    } else {
      out['result${e.key[0].toUpperCase()}${e.key.substring(1)}'] =
          e.value as String;
    }
  }
  return out;
}

void main() {
  final byLang = {for (final l in AppLanguage.values) l: _homeForLang(l)};
  _writeArbDir(bundlePrefix: 'home', dir: 'lib/features/home/l10n', byLang: byLang);

  final drawByLang = {
    for (final l in AppLanguage.values) l: _drawForLang(l),
  };
  _writeArbDir(
    bundlePrefix: 'draw',
    dir: 'lib/features/draw/l10n',
    byLang: drawByLang,
  );

  final shapesByLang = {
    for (final l in AppLanguage.values) l: _shapesForLang(l),
  };
  _writeArbDir(
    bundlePrefix: 'shapes',
    dir: 'lib/features/shapes/l10n',
    byLang: shapesByLang,
  );

  final infoByLang = {
    for (final l in AppLanguage.values) l: _infoMergedForLang(l),
  };
  _writeArbDir(
    bundlePrefix: 'info',
    dir: 'lib/features/info/l10n',
    byLang: infoByLang,
  );

  _syncCoreAppArbsFromRoot();
}

/// Eski `l10n/app_*.arb` dosyalarından çekirdek uygulama ARB’lerini taşır; çoklu
/// dil dosyalarını `app_en` ile doldurur (kabuk metinleri; çevirmen ARB’de günceller).
void _syncCoreAppArbsFromRoot() {
  const movedToDraw = {
    'drawGamePausedTitle',
    'drawContinue',
    'drawStartGame',
    'drawBalloonReady',
    'drawBalloonScoreHint',
    'letterPuzzlePreparing',
  };
  final rootEn = File('l10n/app_en.arb');
  final coreEn = File('lib/core/l10n/arb/app_en.arb');
  final sourceEn = rootEn.existsSync() ? rootEn : coreEn;
  if (!sourceEn.existsSync()) {
    stdout.writeln('Skip core app ARB sync: kaynak app_en.arb yok');
    return;
  }
  final rootTr = File('l10n/app_tr.arb');
  final coreTr = File('lib/core/l10n/arb/app_tr.arb');
  final sourceTr = rootTr.existsSync() ? rootTr : coreTr;
  final outDir = Directory('lib/core/l10n/arb');
  outDir.createSync(recursive: true);

  Map<String, dynamic> trim(Map<String, dynamic> j) {
    final o = <String, dynamic>{};
    for (final e in j.entries) {
      if (e.key.startsWith('@')) {
        final base = e.key.substring(1);
        if (movedToDraw.contains(base)) {
          continue;
        }
      }
      if (movedToDraw.contains(e.key)) {
        continue;
      }
      o[e.key] = e.value;
    }
    return o;
  }

  final en =
      trim(jsonDecode(sourceEn.readAsStringSync()) as Map<String, dynamic>);
  File('${outDir.path}/app_en.arb').writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert(en),
  );
  if (sourceTr.existsSync()) {
    final tr =
        trim(jsonDecode(sourceTr.readAsStringSync()) as Map<String, dynamic>);
    File('${outDir.path}/app_tr.arb').writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(tr),
    );
  }
  for (final lang in AppLanguage.values) {
    final code = _localeCode(lang);
    if (code == 'en' || code == 'tr') {
      continue;
    }
    final copy = Map<String, dynamic>.from(en);
    copy['@@locale'] = code;
    File('${outDir.path}/app_$code.arb').writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(copy),
    );
  }
  stdout.writeln('Synced lib/core/l10n/arb/app_*.arb');
}
