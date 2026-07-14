// Generates feature ARB files from `language_constants.dart` maps.
// Run from repo root: dart run tool/export_l10n_arbs.dart
//

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
        n == 'total' ||
        n == 'minutes' ||
        n == 'percent' ||
        (key == 'parentPanelInsightNumberStruggling' && n == 'number');
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
  out['numbersTitle'] = tool['numberTitle']!;
  out['lettersTitle'] = tool['letterTitle']!;
  out['shapesTitle'] = tool['shapeTitle']!;
  out['colorsTitle'] =
      lang == AppLanguage.turkish ? 'Renk Öğrenme' : 'Learn Colors';
  out['wordsTitle'] =
      lang == AppLanguage.turkish ? 'Kelime Oluşturma' : 'Build Words';

  out['badgeColorMasterName'] =
      lang == AppLanguage.turkish ? 'Renk Ustası' : 'Color Expert';
  out['badgeColorMasterDesc'] = lang == AppLanguage.turkish
      ? '50 renk turunu tamamladın!'
      : 'You completed 50 color rounds!';

  out['badgeWordMasterName'] =
      lang == AppLanguage.turkish ? 'Kelime Ustası' : 'Word Builder';
  out['badgeWordMasterDesc'] = lang == AppLanguage.turkish
      ? '50 kelime tamamladın!'
      : 'You completed 50 words!';

  out['questsRefreshedMessage'] = lang == AppLanguage.turkish
      ? 'Görevler yenilendi.'
      : 'Quests have been refreshed.';
  out['noBadgesFound'] = lang == AppLanguage.turkish
      ? 'Rozet bulunamadı'
      : 'No badges found';

  final isTr = lang == AppLanguage.turkish;
  String t({required String en, required String tr}) => isTr ? tr : en;

  out['homeGreetingWithName'] = t(en: 'Hello, {name}!', tr: 'Merhaba, {name}!');
  out['homeSloganToday'] =
      t(en: 'What shall we learn today?', tr: 'Bugün ne öğrenelim?');
  out['homeStreakDays'] = t(en: '{count}-day streak', tr: '{count} günlük seri');
  out['homeLearningModes'] = t(en: 'Learning Modes', tr: 'Öğrenme Modları');
  out['numbersTitleShort'] = t(en: 'Numbers', tr: 'Rakamlar');
  out['lettersTitleShort'] = t(en: 'Letters', tr: 'Harfler');
  out['shapesTitleShort'] = t(en: 'Shapes', tr: 'Şekiller');
  out['wordsTitleShort'] = t(en: 'Words', tr: 'Kelimeler');
  out['colorsTitleShort'] = t(en: 'Colors', tr: 'Renkler');
  out['numbersSubtitle'] = t(en: 'Draw 0–9', tr: '0–9 çiz');
  out['lettersSubtitle'] = t(en: 'Draw A–Z', tr: 'A–Z çiz');
  out['shapesSubtitle'] = t(en: 'New!', tr: 'Yeni!');
  out['wordsSubtitle'] = t(en: 'Draw words', tr: 'Kelime çiz');
  out['colorsSubtitle'] = t(en: 'Play & learn', tr: 'Oyna ve öğren');
  out['homeWhereYouLeft'] =
      t(en: 'Where you left off: {label}', tr: 'Kaldığın yer: {label}');
  out['homeStepsRemaining'] =
      t(en: '{count} steps left', tr: '{count} adım kaldı');
  out['homeContinueNumber'] = t(en: 'Number {number}', tr: 'Rakam {number}');
  out['homeContinueLetter'] = t(en: 'Letter {letter}', tr: 'Harf {letter}');
  out['homeContinueShape'] = t(en: 'Shape {number}', tr: 'Şekil {number}');
  out['homeContinueWord'] = t(en: 'Words', tr: 'Kelimeler');
  out['homeContinueColor'] = t(en: 'Colors', tr: 'Renkler');
  out['homeContinueColorVision'] =
      t(en: 'Color Vision', tr: 'Renk Görüşü');
  out['settingsTitle'] = t(en: 'Settings', tr: 'Ayarlar');
  out['settingsChildName'] = t(en: 'Name', tr: 'İsim');
  out['settingsChildNameHint'] =
      t(en: 'Enter your name', tr: 'Adını yaz');
  out['settingsSaveName'] = t(en: 'Save', tr: 'Kaydet');
  out['settingsNameSaved'] = t(en: 'Name saved', tr: 'İsim kaydedildi');
  out['settingsAppearance'] = t(en: 'Appearance', tr: 'Görünüm');
  out['settingsLanguage'] = t(en: 'Language', tr: 'Dil');

  out['badgesScreenTitle'] = t(en: 'My Badges', tr: 'Rozetlerim');
  out['badgesEarnedOfTotal'] = t(
    en: '{count} / {total} badges earned',
    tr: '{count} / {total} rozet kazanıldı',
  );
  out['badgesStreakDayCount'] = t(en: '{count} days', tr: '{count} gün');
  out['badgesStreakSubtitle'] =
      t(en: 'Drawing streak', tr: 'Üst üste çizim serisi');

  out['parentPanelTitle'] = t(en: 'Parent Panel', tr: 'Ebeveyn Paneli');
  out['parentPanelWeeklyProgress'] = t(
    en: "{name}'s weekly progress",
    tr: "{name}'in bu haftaki ilerlemesi",
  );
  out['parentPanelWeeklyProgressNoName'] =
      t(en: 'Weekly progress', tr: 'Bu haftaki ilerleme');
  out['parentPanelStatDuration'] = t(en: 'TIME', tr: 'SÜRE');
  out['parentPanelStatCompleted'] = t(en: 'COMPLETED', tr: 'TAMAMLANAN');
  out['parentPanelStatAccuracy'] = t(en: 'AVG. ACCURACY', tr: 'ORT. DOĞRULUK');
  out['parentPanelDurationMinutes'] = t(en: '{minutes}m', tr: '{minutes}dk');
  out['parentPanelAccuracyPercent'] = t(en: '{percent}%', tr: '%{percent}');
  out['parentPanelChartTitle'] =
      t(en: 'Daily drawing time', tr: 'Günlük çizim süresi');
  out['parentPanelInsightLettersLearned'] =
      t(en: 'Letters {range} learned', tr: 'Harf {range} öğrenildi');
  out['parentPanelInsightNumberStruggling'] = t(
    en: 'Struggling with number {number}',
    tr: 'Rakam {number} zorlanıyor',
  );
  out['parentPanelInsightGettingStarted'] = t(
    en: 'Learning journey is just getting started',
    tr: 'Öğrenme yolculuğu yeni başlıyor',
  );
  out['parentPanelInsightMath'] = t(
    en: 'Working on advanced math operations!',
    tr: 'Gelişmiş matematik işlemleri çalışıyor!',
  );
  out['parentPanelMathStrugglingAddition'] = t(
    en: 'Most errors made in Addition. Suggestion: Review Visual & Symbolic Addition.',
    tr: 'En çok Toplama işleminde hata yapıldı. Öneri: Görsel & Sembolik Toplama tekrarı.',
  );
  out['parentPanelMathStrugglingSubtraction'] = t(
    en: 'Most errors made in Subtraction. Suggestion: Review Level A/B Subtraction.',
    tr: 'En çok Çıkarma işleminde hata yapıldı. Öneri: Seviye A/B Çıkarma tekrarı.',
  );
  out['parentPanelMathStrugglingTens'] = t(
    en: 'Most errors made in Tens (10-100). Suggestion: Review Tens cards.',
    tr: 'En çok Onluk Sayılarda (10-100) hata yapıldı. Öneri: Onluk kartları tekrarı.',
  );
  out['parentPanelToday'] = t(en: 'Today', tr: 'Bugün');
  out['parentPanelYesterday'] = t(en: 'Yesterday', tr: 'Dün');
  out['settingsParentPanel'] = t(en: 'Parent Panel', tr: 'Ebeveyn Paneli');
  out['settingsParentPanelSubtitle'] =
      t(en: 'Progress & insights', tr: 'İlerleme ve içgörüler');

  // New settings redesign l10n keys
  out['settingsSectionChild'] = t(en: 'My Settings', tr: 'Benim Ayarlarım');
  out['settingsSectionParent'] = t(en: 'Parent Area', tr: 'Ebeveyn Alanı');
  out['settingsSectionParentWarning'] = t(
    en: 'Controls and reports for parents',
    tr: 'Ebeveynlere özel kontroller ve raporlar',
  );
  out['settingsThemeLight'] = t(en: 'Light', tr: 'Açık');
  out['settingsThemeDark'] = t(en: 'Dark', tr: 'Koyu');
  out['settingsThemeSystem'] = t(en: 'System', tr: 'Sistem');
  out['settingsChooseLanguage'] = t(en: 'Choose Language', tr: 'Dil Seçimi');
  out['settingsChooseTheme'] = t(en: 'Choose Theme', tr: 'Tema Seçimi');
  out['settingsNameSavedShort'] = t(en: 'Saved', tr: 'Kaydedildi');
  out['settingsEmptyNameError'] =
      t(en: 'Name cannot be empty', tr: 'İsim boş olamaz');

  // Restored shop, quests, and math localization keys
  out['shopScreenSubtitle'] =
      t(en: 'Customize your avatar!', tr: 'Avatarını özelleştir!');
  out['shopSlotNone'] = t(en: 'Remove', tr: 'Çıkar');
  out['itemEquipped'] = t(en: '{item} equipped!', tr: '{item} giyildi!');
  out['itemUnequipped'] = t(en: '{slot} removed', tr: '{slot} çıkarıldı');
  out['slotHat'] = t(en: 'Hat', tr: 'Şapka');
  out['slotGlasses'] = t(en: 'Glasses', tr: 'Gözlük');
  out['slotOutfit'] = t(en: 'Outfit', tr: 'Kıyafet');
  out['questsScreenSubtitle'] = t(
    en: 'Complete quests and earn points!',
    tr: 'Görevleri tamamla, puan kazan!',
  );
  out['questsDailySection'] = t(en: 'Daily Quests', tr: 'Günlük Görevler');
  out['questsWeeklySection'] = t(en: 'Weekly Quests', tr: 'Haftalık Görevler');
  out['mathAdvancedTitle'] =
      t(en: 'Advanced Math', tr: 'Gelişmiş Matematik');
  out['mathAdvancedSubtitle'] = t(
    en: 'Practicing complex operations',
    tr: 'Karmaşık işlemleri pratik yap',
  );

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
      _templateFromTwoIntFn(action['correctTotal']);
  out['drawClear'] = action['clear']! as String;
  out['drawPen'] = action['pen']! as String;
  out['drawEraser'] = action['eraser']! as String;
  out['drawRecognize'] = action['recognize']! as String;

  final tool = localizedToolControlPanelTexts[lang] ??
      localizedToolControlPanelTexts[AppLanguage.english]!;
  out['drawPenColor'] = tool['penColor']!;
  out['drawNumberSectionTitle'] = tool['numberTitle']!;
  out['drawLetterSectionTitle'] = tool['letterTitle']!;
  out['drawShapeSectionTitle'] = tool['shapeTitle']!;
  out['drawWordSectionTitle'] =
      lang == AppLanguage.turkish ? 'Kelime Oluşturma' : 'Build Words';

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
    out['info${e.key[0].toUpperCase()}${e.key.substring(1)}'] =
        e.value;
  }
  final res = localizedResultScreenTexts[lang] ??
      localizedResultScreenTexts[AppLanguage.english]!;
  for (final e in res.entries) {
    if (e.key == 'progress') {
      out['resultProgress'] = _templateFromTwoIntFn(e.value);
    } else {
      out['result${e.key[0].toUpperCase()}${e.key.substring(1)}'] =
          e.value.toString();
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
