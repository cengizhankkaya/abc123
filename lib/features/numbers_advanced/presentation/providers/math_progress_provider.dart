import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:abc123/core/constants/audio.dart';
import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/domain/ports/i_audio_service.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/numbers_advanced/application/math_problem_generator.dart';
import 'package:abc123/features/numbers_advanced/application/usecases/recognize_multi_digit.dart';
import 'package:abc123/features/numbers_advanced/domain/math_difficulty.dart';
import 'package:abc123/features/numbers_advanced/domain/math_operation.dart';
import 'package:abc123/features/numbers_advanced/domain/number_lesson.dart';
import 'package:abc123/features/parent_panel/domain/progress_source.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ────────────────────── Yardımcı tipler ──────────────────────

/// Matematik modülü türleri (Ebeveyn Paneli istatistikleri için).
enum MathType { addition, subtraction, tens, visual, free }

/// Serbest pratik / onluklar modülünde bir basamağın çizim durumu.
enum DigitBoxState { empty, drawing, done }

// ────────────────────────────────────────────────────────────

/// Tüm `numbers_advanced` modülünün state yöneticisi.
///
/// Her ekran (onluklar, serbest pratik, görsel toplama, sembolik işlem)
/// bu provider üzerinden hem problem üretimine hem de ilerleme takibine erişir.
/// Gamification entegrasyonu [GamificationProvider] üzerinden yapılır.
class MathProgressProvider extends ChangeNotifier implements ProgressSource {
  MathProgressProvider({
    required GamificationProvider gamification,
    required RecognizeMultiDigit recognizeMultiDigitUseCase,
  })  : _gamification = gamification,
        _recognizeMultiDigitUseCase = recognizeMultiDigitUseCase {
    _generator = MathProblemGenerator();
    _loadProgress();
  }

  final GamificationProvider _gamification;
  final RecognizeMultiDigit _recognizeMultiDigitUseCase;
  late final MathProblemGenerator _generator;

  // ─────────────────── İlerleme (SharedPreferences) ───────────────────

  /// Her seviye için (doğru, toplam) çifti; %80 kilidi buradan hesaplanır.
  final Map<DifficultyLevel, _LevelStat> _levelStats = {
    DifficultyLevel.levelA: _LevelStat(),
    DifficultyLevel.levelB: _LevelStat(),
    DifficultyLevel.levelC: _LevelStat(),
  };

  int _additionsCompleted = 0;
  int _subtractionsCompleted = 0;
  int _tensCompleted = 0;
  int _visualCompleted = 0;
  int _freeCompleted = 0;

  // Hata sayaçları
  int _wrongAdditionsCount = 0;
  int _wrongSubtractionsCount = 0;
  int _wrongTensCount = 0;

  // Ebeveyn Paneli için genel istatistikler
  int get additionsCompleted => _additionsCompleted;
  int get subtractionsCompleted => _subtractionsCompleted;
  int get tensCompleted => _tensCompleted;
  int get visualCompleted => _visualCompleted;
  int get freeCompleted => _freeCompleted;

  int get wrongAdditionsCount => _wrongAdditionsCount;
  int get wrongSubtractionsCount => _wrongSubtractionsCount;
  int get wrongTensCount => _wrongTensCount;

  // ─────────────────── Aktif problem ───────────────────

  /// Aktif sembolik işlem sorusu.
  MathOperation? _currentOperation;
  MathOperation? get currentOperation => _currentOperation;

  /// Aktif onluklar dersi.
  NumberLesson? _currentLesson;
  NumberLesson? get currentLesson => _currentLesson;

  /// Aktif serbest pratik sayısı.
  int _currentFreeNumber = 0;
  int get currentFreeNumber => _currentFreeNumber;

  /// Aktif görsel toplama.
  MathOperation? _currentVisual;
  MathOperation? get currentVisual => _currentVisual;

  // ─────────────────── Seçili seviye ───────────────────

  DifficultyLevel _selectedLevel = DifficultyLevel.levelA;
  DifficultyLevel get selectedLevel => _selectedLevel;

  // ─────────────────── Çizim state ───────────────────

  /// Yüzler basamağı için çizim noktaları.
  final List<DrawingPointMath?> hundredsPoints = [];

  /// Onlar basamağı için çizim noktaları.
  final List<DrawingPointMath?> tensPoints = [];

  /// Birler basamağı için çizim noktaları.
  final List<DrawingPointMath?> unitsPoints = [];

  /// Aktif kutu (0 = onlar, 1 = birler, 2 = yüzler).
  int activeBox = 0;

  /// İpucu modu (soluk arka plan rakamı).
  bool hintEnabled = true;

  // ─────────────────── Geri bildirim ───────────────────

  bool? _lastAnswerCorrect;
  bool? get lastAnswerCorrect => _lastAnswerCorrect;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// Görsel toplama hata animasyonu için bayrak
  bool _isCountingMode = false;
  bool get isCountingMode => _isCountingMode;

  // ─────────────────── Public API: Problem üretimi ───────────────────

  /// Yeni onluk dersi başlatır.
  void startTensLesson(int targetNumber) {
    _currentLesson = _generator.tensLessonFor(targetNumber);
    hundredsPoints.clear();
    tensPoints.clear();
    unitsPoints.clear();
    activeBox = targetNumber >= 100 ? 2 : 0;
    _lastAnswerCorrect = null;
    hintEnabled = true;
    notifyListeners();
  }

  /// Yeni serbest pratik sorusu başlatır.
  void startFreePractice() {
    _currentFreeNumber = _generator.generateFreePracticeNumber();
    hundredsPoints.clear();
    tensPoints.clear();
    unitsPoints.clear();
    activeBox = _currentFreeNumber >= 100 ? 2 : 0;
    _lastAnswerCorrect = null;
    hintEnabled = true;
    notifyListeners();
  }

  /// Yeni sembolik işlem sorusu başlatır.
  void startSymbolicOperation({required bool isAddition}) {
    _currentOperation = isAddition
        ? _generator.generateAddition(_selectedLevel)
        : _generator.generateSubtraction(_selectedLevel);
    hundredsPoints.clear();
    tensPoints.clear();
    unitsPoints.clear();
    activeBox = (_currentOperation?.result ?? 0) >= 100 ? 2 : 0;
    _lastAnswerCorrect = null;
    hintEnabled = true;
    notifyListeners();
  }

  /// Yeni görsel toplama sorusu başlatır.
  void startVisualAddition() {
    _currentVisual = _generator.generateVisualAddition();
    hundredsPoints.clear();
    tensPoints.clear();
    unitsPoints.clear();
    activeBox = (_currentVisual?.result ?? 0) >= 100 ? 2 : 0;
    _lastAnswerCorrect = null;
    _isCountingMode = false;
    hintEnabled = true;
    notifyListeners();
  }

  // ─────────────────── Çizim kontrolü ───────────────────

  void addPoint(DrawingPointMath point) {
    if (activeBox == 2) {
      hundredsPoints.add(point);
    } else if (activeBox == 0) {
      tensPoints.add(point);
    } else {
      unitsPoints.add(point);
    }
    notifyListeners();
  }

  void endStroke() {
    if (activeBox == 2) {
      hundredsPoints.add(null);
    } else if (activeBox == 0) {
      tensPoints.add(null);
    } else {
      unitsPoints.add(null);
    }
    notifyListeners();
  }

  void clearActiveBox() {
    if (activeBox == 2) {
      hundredsPoints.clear();
    } else if (activeBox == 0) {
      tensPoints.clear();
    } else {
      unitsPoints.clear();
    }
    notifyListeners();
  }

  void setActiveBox(int box) {
    activeBox = box;
    notifyListeners();
  }

  void toggleHint() {
    hintEnabled = !hintEnabled;
    notifyListeners();
  }

  // ─────────────────── Seviye seçimi ───────────────────

  bool canUnlockLevel(DifficultyLevel level) {
    if (level == DifficultyLevel.levelA) return true;
    final prev = level == DifficultyLevel.levelB ? DifficultyLevel.levelA : DifficultyLevel.levelB;
    return _levelStats[prev]!.accuracy >= 0.80;
  }

  List<DifficultyLevel> get unlockedLevels => DifficultyLevel.values.where(canUnlockLevel).toList();

  void selectLevel(DifficultyLevel level) {
    if (!canUnlockLevel(level)) return;
    _selectedLevel = level;
    notifyListeners();
  }

  // ─────────────────── Tanıma ve değerlendirme ───────────────────

  /// Tek kutucuklu (tek basamak) tanıma + değerlendirme.
  Future<void> evaluateSingleDigit({
    required GlobalKey boxKey,
    required int expectedResult,
    required MathType type,
    required BuildContext context,
  }) async {
    if (tensPoints.isEmpty) return;
    _isLoading = true;
    notifyListeners();

    try {
      final pngBytes = await _renderBoxToBytes(context, boxKey, tensPoints);
      if (pngBytes == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      final recognizedResult = await _recognizeMultiDigitUseCase.recognizeDigit(pngBytes);
      recognizedResult.fold(
        (failure) {
          _isLoading = false;
          notifyListeners();
        },
        (recognized) async {
          final isCorrect = recognized == expectedResult;
          await _handleResult(isCorrect: isCorrect, type: type, level: _selectedLevel);
        },
      );
    } catch (_) {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Çift veya üç kutucuklu (iki/üç basamak) tanıma + değerlendirme.
  Future<void> evaluateMultiDigit({
    required GlobalKey tensKey,
    required GlobalKey unitsKey,
    required int expectedResult,
    required MathType type,
    required BuildContext context,
    GlobalKey? hundredsKey,
    bool singleBox = false,
  }) async {
    final hasHundreds = hundredsPoints.isNotEmpty;
    final hasTens = tensPoints.isNotEmpty;
    final hasUnits = unitsPoints.isNotEmpty;

    if (!hasHundreds && !hasTens && !hasUnits) return;
    _isLoading = true;
    notifyListeners();

    try {
      if (singleBox) {
        // Tek basamak bekleniyor (birler hanesi)
        final pngBytes = await _renderBoxToBytes(context, unitsKey, unitsPoints);
        if (pngBytes == null) {
          _isLoading = false;
          notifyListeners();
          return;
        }
        final result = await _recognizeMultiDigitUseCase.recognizeDigit(pngBytes);
        result.fold(
          (failure) {},
          (recognized) async {
            final isCorrect = recognized == expectedResult;
            await _handleResult(isCorrect: isCorrect, type: type, level: _selectedLevel);
          },
        );
      } else if (hundredsKey != null) {
        // Üç basamak bekleniyor (ör: 100)
        final hundredsBytes = await _renderBoxToBytes(context, hundredsKey, hundredsPoints);
        final tensBytes = await _renderBoxToBytes(context, tensKey, tensPoints);
        final unitsBytes = await _renderBoxToBytes(context, unitsKey, unitsPoints);
        if (hundredsBytes == null || tensBytes == null || unitsBytes == null) {
          _isLoading = false;
          notifyListeners();
          return;
        }
        final result = await _recognizeMultiDigitUseCase.recognizeTripleDigit(
          hundredsBytes: hundredsBytes,
          tensBytes: tensBytes,
          unitsBytes: unitsBytes,
        );
        result.fold(
          (failure) {},
          (recognized) async {
            final isCorrect = recognized == expectedResult;
            await _handleResult(isCorrect: isCorrect, type: type, level: _selectedLevel);
          },
        );
      } else {
        final tensBytes = await _renderBoxToBytes(context, tensKey, tensPoints);
        final unitsBytes = await _renderBoxToBytes(context, unitsKey, unitsPoints);
        if (tensBytes == null || unitsBytes == null) {
          _isLoading = false;
          notifyListeners();
          return;
        }
        final result = await _recognizeMultiDigitUseCase.recognizeMultiDigit(
            tensBytes: tensBytes, unitsBytes: unitsBytes);
        result.fold(
          (failure) {},
          (recognized) async {
            final isCorrect = recognized == expectedResult;
            await _handleResult(isCorrect: isCorrect, type: type, level: _selectedLevel);
          },
        );
      }
    } catch (_) {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─────────────────── Gamification ───────────────────

  Future<void> _handleResult({
    required bool isCorrect,
    required MathType type,
    required DifficultyLevel level,
  }) async {
    _lastActivityDate = DateTime.now();
    _lastAnswerCorrect = isCorrect;
    _isLoading = false;

    if (isCorrect) {
      // Ses geri bildirimi
      getIt<IAudioService>().playEffect(AppAudios.success);

      // Puan
      await _gamification.addPoints(GamificationConstants.pointsPerCorrectDraw);

      // Sayaçlar
      switch (type) {
        case MathType.addition:
          _additionsCompleted++;
          if (_additionsCompleted == 1) {
            await _gamification.unlockMathBadge(
              GamificationConstants.badgeMathFirstAddition,
            );
          }
        case MathType.subtraction:
          _subtractionsCompleted++;
          if (_subtractionsCompleted >= 20) {
            await _gamification.unlockMathBadge(
              GamificationConstants.badgeSubtractionMaster,
            );
          }
        case MathType.tens:
          _tensCompleted++;
          if (_tensCompleted >= 10) {
            await _gamification.unlockMathBadge(
              GamificationConstants.badgeTensHero,
            );
          }
        case MathType.visual:
          _visualCompleted++;
        case MathType.free:
          _freeCompleted++;
      }

      // Seviye istatistiği
      _levelStats[level]!.addCorrect();
      await _saveProgress();
    } else {
      // Yanlış cevap
      getIt<IAudioService>().playEffect(AppAudios.fail);
      _levelStats[level]!.addWrong();
      hintEnabled = true;

      switch (type) {
        case MathType.addition:
          _wrongAdditionsCount++;
        case MathType.subtraction:
          _wrongSubtractionsCount++;
        case MathType.tens:
          _wrongTensCount++;
        case MathType.visual:
          _isCountingMode = true; // Hatalı görsel toplamada sayma rehberini aç
        case MathType.free:
          break;
      }

      await _saveProgress();
    }

    notifyListeners();
  }

  // ─────────────────── Renderer ───────────────────

  Future<Uint8List?> _renderBoxToBytes(
    BuildContext context,
    GlobalKey key,
    List<DrawingPointMath?> points,
  ) async {
    try {
      const size = 280;
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final rect = Rect.fromLTWH(0, 0, size as double, size as double);
      canvas.drawRect(rect, Paint()..color = Colors.white);
      _paintPoints(canvas, points);
      final picture = recorder.endRecording();
      final image = await picture.toImage(size, size);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (_) {
      return null;
    }
  }

  void _paintPoints(Canvas canvas, List<DrawingPointMath?> points) {
    for (var i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      if (current != null && next != null) {
        canvas.drawLine(
          current.point,
          next.point,
          current.paint,
        );
      } else if (current != null && next == null) {
        canvas.drawCircle(
          current.point,
          current.paint.strokeWidth / 2,
          current.paint,
        );
      }
    }
  }

  // ─────────────────── Persist ───────────────────

  static const String _keyAdditions = 'math_additions_completed';
  static const String _keySubtractions = 'math_subtractions_completed';
  static const String _keyTens = 'math_tens_completed';
  static const String _keyVisual = 'math_visual_completed';
  static const String _keyFree = 'math_free_completed';
  static const String _keyLevelACorrect = 'math_level_a_correct';
  static const String _keyLevelATotal = 'math_level_a_total';
  static const String _keyLevelBCorrect = 'math_level_b_correct';
  static const String _keyLevelBTotal = 'math_level_b_total';
  static const String _keyLevelCCorrect = 'math_level_c_correct';
  static const String _keyLevelCTotal = 'math_level_c_total';

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    _additionsCompleted = prefs.getInt(_keyAdditions) ?? 0;
    _subtractionsCompleted = prefs.getInt(_keySubtractions) ?? 0;
    _tensCompleted = prefs.getInt(_keyTens) ?? 0;
    _visualCompleted = prefs.getInt(_keyVisual) ?? 0;
    _freeCompleted = prefs.getInt(_keyFree) ?? 0;

    _levelStats[DifficultyLevel.levelA] = _LevelStat(
      correct: prefs.getInt(_keyLevelACorrect) ?? 0,
      total: prefs.getInt(_keyLevelATotal) ?? 0,
    );
    _levelStats[DifficultyLevel.levelB] = _LevelStat(
      correct: prefs.getInt(_keyLevelBCorrect) ?? 0,
      total: prefs.getInt(_keyLevelBTotal) ?? 0,
    );
    _levelStats[DifficultyLevel.levelC] = _LevelStat(
      correct: prefs.getInt(_keyLevelCCorrect) ?? 0,
      total: prefs.getInt(_keyLevelCTotal) ?? 0,
    );
    notifyListeners();
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyAdditions, _additionsCompleted);
    await prefs.setInt(_keySubtractions, _subtractionsCompleted);
    await prefs.setInt(_keyTens, _tensCompleted);
    await prefs.setInt(_keyVisual, _visualCompleted);
    await prefs.setInt(_keyFree, _freeCompleted);

    final a = _levelStats[DifficultyLevel.levelA]!;
    final b = _levelStats[DifficultyLevel.levelB]!;
    final c = _levelStats[DifficultyLevel.levelC]!;
    await prefs.setInt(_keyLevelACorrect, a.correct);
    await prefs.setInt(_keyLevelATotal, a.total);
    await prefs.setInt(_keyLevelBCorrect, b.correct);
    await prefs.setInt(_keyLevelBTotal, b.total);
    await prefs.setInt(_keyLevelCCorrect, c.correct);
    await prefs.setInt(_keyLevelCTotal, c.total);
  }

  _LevelStat statFor(DifficultyLevel level) => _levelStats[level] ?? _LevelStat();

  // ─────────────────── ProgressSource İmplementasyonu ───────────────────

  DateTime? _lastActivityDate;

  @override
  String get moduleName => 'math_advanced';

  @override
  double get completionPercentage {
    final totalDone = additionsCompleted +
        subtractionsCompleted +
        tensCompleted +
        visualCompleted +
        freeCompleted;
    return (totalDone / 20.0 * 100.0).clamp(0.0, 100.0);
  }

  @override
  double get accuracyRate {
    final totalDone = additionsCompleted +
        subtractionsCompleted +
        tensCompleted +
        visualCompleted +
        freeCompleted;
    final totalWrong = wrongAdditionsCount + wrongSubtractionsCount + wrongTensCount;
    final totalAttempts = totalDone + totalWrong;
    if (totalAttempts == 0) return 100;
    return (totalDone / totalAttempts * 100.0).clamp(0.0, 100.0);
  }

  @override
  DateTime? get lastActivityDate => _lastActivityDate;

  @override
  List<String> get strugglingItems {
    final map = <String, int>{
      if (wrongAdditionsCount > 0) 'Toplama İşlemi': wrongAdditionsCount,
      if (wrongSubtractionsCount > 0) 'Çıkarma İşlemi': wrongSubtractionsCount,
      if (wrongTensCount > 0) 'Onluklar (10-100)': wrongTensCount,
    };
    final entries = map.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return entries.map((e) => e.key).toList();
  }
}

// ────────────────────── Yardımcı sınıflar ──────────────────────

/// Tek basamak çizim noktası veri modeli (math modülüne özgü).
class DrawingPointMath {
  const DrawingPointMath({required this.point, required this.paint});

  final Offset point;
  final Paint paint;
}

/// Bir seviyenin doğru/toplam istatistiği.
class _LevelStat {
  _LevelStat({this.correct = 0, this.total = 0});

  int correct;
  int total;

  double get accuracy => total == 0 ? 0.0 : correct / total;

  int get percent => (accuracy * 100).round();

  void addCorrect() {
    correct++;
    total++;
  }

  void addWrong() {
    total++;
  }
}
