import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:abc123/core/constants/audio.dart';
import 'package:abc123/core/constants/gamification_constants.dart';
import 'package:abc123/core/domain/ports/i_audio_service.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/numbers_advanced/application/math_problem_generator.dart';
import 'package:abc123/features/numbers_advanced/application/usecases/recognize_multi_digit.dart';
import 'package:abc123/features/numbers_advanced/domain/math_difficulty.dart';
import 'package:abc123/features/numbers_advanced/domain/math_operation.dart';
import 'package:abc123/features/numbers_advanced/domain/number_lesson.dart';
import 'package:abc123/features/numbers_advanced/domain/math_progress_stats.dart';
import 'package:abc123/features/numbers_advanced/domain/repositories/i_math_progress_repository.dart';
import 'package:abc123/features/parent_panel/domain/progress_source.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

// ────────────────────── Yardımcı tipler ──────────────────────

/// Matematik modülü türleri (Ebeveyn Paneli istatistikleri için).
enum MathType { addition, subtraction, tens, visual, free }

/// Serbest pratik / onluklar modülünde bir basamağın çizim durumu.
enum DigitBoxState { empty, drawing, done }

// ────────────────────────────────────────────────────────────

/// Tüm `numbers_advanced` modülünün state yöneticisi.
@injectable
class MathProgressProvider extends ChangeNotifier implements ProgressSource {
  MathProgressProvider({
    required GamificationProvider gamification,
    required RecognizeMultiDigit recognizeMultiDigitUseCase,
    required IMathProgressRepository repository,
    required IAudioService audioService,
  })  : _gamification = gamification,
        _recognizeMultiDigitUseCase = recognizeMultiDigitUseCase,
        _repository = repository,
        _audioService = audioService {
    _generator = MathProblemGenerator();
    _loadProgress();
  }

  final GamificationProvider _gamification;
  final RecognizeMultiDigit _recognizeMultiDigitUseCase;
  final IMathProgressRepository _repository;
  final IAudioService _audioService;
  late final MathProblemGenerator _generator;

  // ─────────────────── İlerleme ───────────────────

  MathProgressStats _stats = MathProgressStats();

  // Hata sayaçları (bunlar kalıcı olarak kaydedilmiyordu, session bazlı)
  int _wrongAdditionsCount = 0;
  int _wrongSubtractionsCount = 0;
  int _wrongTensCount = 0;

  // Ebeveyn Paneli için genel istatistikler
  int get additionsCompleted => _stats.additionsCompleted;
  int get subtractionsCompleted => _stats.subtractionsCompleted;
  int get tensCompleted => _stats.tensCompleted;
  int get visualCompleted => _stats.visualCompleted;
  int get freeCompleted => _stats.freeCompleted;

  int get wrongAdditionsCount => _wrongAdditionsCount;
  int get wrongSubtractionsCount => _wrongSubtractionsCount;
  int get wrongTensCount => _wrongTensCount;

  // ─────────────────── Aktif problem ───────────────────

  MathOperation? _currentOperation;
  MathOperation? get currentOperation => _currentOperation;

  NumberLesson? _currentLesson;
  NumberLesson? get currentLesson => _currentLesson;

  int _currentFreeNumber = 0;
  int get currentFreeNumber => _currentFreeNumber;

  MathOperation? _currentVisual;
  MathOperation? get currentVisual => _currentVisual;

  // ─────────────────── Seçili seviye ───────────────────

  DifficultyLevel _selectedLevel = DifficultyLevel.levelA;
  DifficultyLevel get selectedLevel => _selectedLevel;

  // ─────────────────── Çizim state ───────────────────

  final List<DrawingPointMath?> hundredsPoints = [];
  final List<DrawingPointMath?> tensPoints = [];
  final List<DrawingPointMath?> unitsPoints = [];

  int activeBox = 0;
  bool hintEnabled = true;

  // ─────────────────── Geri bildirim ───────────────────

  bool? _lastAnswerCorrect;
  bool? get lastAnswerCorrect => _lastAnswerCorrect;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isCountingMode = false;
  bool get isCountingMode => _isCountingMode;

  // ─────────────────── Public API: Problem üretimi ───────────────────

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
    return _stats.levelStats[prev]!.accuracy >= 0.80;
  }

  List<DifficultyLevel> get unlockedLevels => DifficultyLevel.values.where(canUnlockLevel).toList();

  void selectLevel(DifficultyLevel level) {
    if (!canUnlockLevel(level)) return;
    _selectedLevel = level;
    notifyListeners();
  }

  // ─────────────────── Tanıma ve değerlendirme ───────────────────

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
      _audioService.playEffect(AppAudios.success);
      await _gamification.addPoints(GamificationConstants.pointsPerCorrectDraw);

      switch (type) {
        case MathType.addition:
          _stats.additionsCompleted++;
          if (_stats.additionsCompleted == 1) {
            await _gamification.unlockMathBadge(GamificationConstants.badgeMathFirstAddition);
          }
        case MathType.subtraction:
          _stats.subtractionsCompleted++;
          if (_stats.subtractionsCompleted >= 20) {
            await _gamification.unlockMathBadge(GamificationConstants.badgeSubtractionMaster);
          }
        case MathType.tens:
          _stats.tensCompleted++;
          if (_stats.tensCompleted >= 10) {
            await _gamification.unlockMathBadge(GamificationConstants.badgeTensHero);
          }
        case MathType.visual:
          _stats.visualCompleted++;
        case MathType.free:
          _stats.freeCompleted++;
      }

      _stats.levelStats[level]!.addCorrect();
      await _saveProgress();
    } else {
      _audioService.playEffect(AppAudios.fail);
      _stats.levelStats[level]!.addWrong();
      hintEnabled = true;

      switch (type) {
        case MathType.addition:
          _wrongAdditionsCount++;
        case MathType.subtraction:
          _wrongSubtractionsCount++;
        case MathType.tens:
          _wrongTensCount++;
        case MathType.visual:
          _isCountingMode = true;
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

  Future<void> _loadProgress() async {
    _stats = await _repository.getProgress();
    notifyListeners();
  }

  Future<void> _saveProgress() async {
    await _repository.saveProgress(_stats);
  }

  LevelStat statFor(DifficultyLevel level) => _stats.levelStats[level] ?? LevelStat();

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

class DrawingPointMath {
  const DrawingPointMath({required this.point, required this.paint});

  final Offset point;
  final Paint paint;
}
