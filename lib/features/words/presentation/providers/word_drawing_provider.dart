import 'dart:ui' as ui;

import 'package:abc123/core/di/injection.dart';
import 'package:abc123/core/infrastructure/audio/audio_service.dart';
import 'package:abc123/core/logging/app_logger.dart';
import 'package:abc123/core/presentation/responsive/responsive_size.dart';
import 'package:abc123/features/draw/application/usecases/recognize_letter_use_case.dart';
import 'package:abc123/features/draw/domain/drawing_content.dart';
import 'package:abc123/features/draw/presentation/widgets/build_drawing_area.dart';
import 'package:abc123/features/words/application/usecases/get_word_list_use_case.dart';
import 'package:abc123/features/words/domain/word_drawing_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:abc123/features/parent_panel/domain/progress_source.dart';

final class WordDrawingProvider with ChangeNotifier implements ProgressSource {
  List<DrawingPoint?> points = [];
  bool eraseMode = false;
  Color selectedColor = Colors.black;
  double strokeWidth = 35.0;

  bool isLoading = false;
  bool showResult = false;
  String recognitionResult = '';
  ui.Image? drawingImage;

  double volume = 1.0;

  WordDrawingSession? _session;
  late DrawingGuide _activeGuide;
  Locale? _locale;

  final RecognizeLetterUseCase _recognizeLetterUseCase;
  final GetWordListUseCase _getWordListUseCase;

  WordDrawingProvider() :
    _recognizeLetterUseCase = getIt<RecognizeLetterUseCase>(),
    _getWordListUseCase = getIt<GetWordListUseCase>() {
    volume = AudioService().currentVolume;
    _activeGuide = DrawingContentProvider.activeLetterGuide;
  }

  bool get hasSession => _session != null;
  WordDrawingSession get session => _session!;

  DrawingGuide get currentActiveGuide => _activeGuide;

  void ensureSessionForLocale(Locale locale) {
    if (_locale?.languageCode == locale.languageCode && _session != null) {
      return;
    }
    _locale = locale;
    _session = WordDrawingSession(words: _getWordListUseCase(locale));
    _syncGuideToTargetLetter();
    _resetDrawingState();
  }

  String get targetLetter => session.targetLetter;

  void _syncGuideToTargetLetter() {
    final idx = _letterIndex(targetLetter);
    _activeGuide = DrawingContentProvider.getLetterGuide(idx);
  }

  int _letterIndex(String upperAZ) {
    final c = upperAZ.codeUnitAt(0);
    final a = 'A'.codeUnitAt(0);
    final idx = c - a;
    if (idx < 0 || idx > 25) return 0;
    return idx;
  }

  String get hintDisplayKey => session.currentWord.displayKey;
  String get hintEmoji => session.currentWord.emoji;
  String get hintSpelling => session.currentWord.spelling;

  Future<void> recognize(BuildContext context) async {
    if (points.isEmpty) {
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final image = await _renderToImage(context);
      if (image == null) {
        isLoading = false;
        notifyListeners();
        return;
      }

      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        isLoading = false;
        notifyListeners();
        return;
      }

      final pngBytes = byteData.buffer.asUint8List();
      final resultEither = await _recognizeLetterUseCase(pngBytes);
      final result = resultEither.fold(
        (_) => '?',
        (letter) => letter,
      );

      drawingImage = image;
      recognitionResult = result;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<ui.Image?> _renderToImage(BuildContext context) async {
    try {
      final responsive = ResponsiveSize(context);
      final drawingSize = responsive.drawingAreaSize;
      final scaleRatio = drawingSize / 280.0;

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final rect = Rect.fromLTWH(0, 0, drawingSize, drawingSize);
      canvas.drawRect(rect, Paint()..color = Colors.white);
      canvas.scale(scaleRatio, scaleRatio);

      final painter = DrawingPainter(pointsList: points);
      painter.paint(canvas, const Size(280, 280));

      final picture = recorder.endRecording();
      return await picture.toImage(drawingSize.toInt(), drawingSize.toInt());
    } catch (e, st) {
      getIt<AppLogger>().error(
        'Image render failed',
        tag: 'WordDraw',
        error: e,
        stackTrace: st,
      );
      return null;
    }
  }

  /// Sonuç ekranı sonrası: tryAgain → aynı harf; continue → ilerlet.
  ///
  /// Geri dönüş: `wordCompletedNow`.
  /// Sonuç ekranı sonrası: tryAgain → aynı harf; continue → ilerlet.
  ///
  /// Geri dönüş: `wordCompletedNow`.
  bool onResultAction({required bool isCorrect, required bool tryAgain}) {
    _recordProgressAttempt(isCorrect);
    if (tryAgain) {
      clearDrawing();
      return false;
    }

    final r = session.registerAttempt(isCorrect: isCorrect);
    _syncGuideToTargetLetter();
    clearDrawing();
    return r.wordCompletedNow;
  }

  bool evaluateRecognitionResult() => session.evaluateRecognitionResult(recognitionResult);

  void addPoint(DrawingPoint? point) {
    points.add(point);
    notifyListeners();
  }

  void endLine() {
    points.add(null);
    notifyListeners();
  }

  void clear() {
    points.clear();
    notifyListeners();
  }

  void _resetDrawingState() {
    points.clear();
    showResult = false;
    drawingImage = null;
    recognitionResult = '';
  }

  void clearDrawing() {
    _resetDrawingState();
    notifyListeners();
  }

  void setEraseMode(bool value) {
    eraseMode = value;
    notifyListeners();
  }

  void setColor(Color color) {
    selectedColor = color;
    notifyListeners();
  }

  void setStrokeWidth(double width) {
    strokeWidth = width;
    notifyListeners();
  }

  void adjustStrokeWidthForScreenSize(double width) {
    setStrokeWidth(width);
  }

  void setVolume(double value) {
    volume = value;
    AudioService().setVolume(value);
    notifyListeners();
  }

  // ─────────────────── ProgressSource İmplementasyonu ───────────────────

  DateTime? _lastActivityDate;
  final Map<String, int> _strugglingItemsMap = {};

  void _recordProgressAttempt(bool isCorrect) {
    _lastActivityDate = DateTime.now();
    if (!isCorrect && hasSession) {
      final key = session.currentWord.displayKey;
      _strugglingItemsMap[key] = (_strugglingItemsMap[key] ?? 0) + 1;
    }
  }

  @override
  String get moduleName => 'words';

  @override
  double get completionPercentage {
    if (!hasSession) return 0.0;
    return (session.completedWords / 10.0 * 100.0).clamp(0.0, 100.0);
  }

  @override
  double get accuracyRate {
    if (!hasSession || session.totalAttempts == 0) return 100.0;
    return (session.correctLetters / session.totalAttempts * 100.0).clamp(0.0, 100.0);
  }

  @override
  DateTime? get lastActivityDate => _lastActivityDate;

  @override
  List<String> get strugglingItems {
    final entries = _strugglingItemsMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries.map((e) => e.key).toList();
  }
}

