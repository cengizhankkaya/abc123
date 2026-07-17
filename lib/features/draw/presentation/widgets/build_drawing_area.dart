
import 'package:abc123/core/constants/app_radii.dart';
import 'package:abc123/core/constants/app_sizes.dart';
import 'package:abc123/features/draw/l10n/generated/draw_localizations.dart';
import 'package:flutter/material.dart';

/// Çizim alanını oluşturan widget (`16_performance.md` — widget > function).
class DrawingArea extends StatelessWidget {
  const DrawingArea({
    required this.drawingAreaKey,
    required this.points,
    required this.eraseMode,
    required this.selectedColor,
    required this.strokeWidth,
    required this.showResult,
    required this.isLoading,
    required this.recognitionResult,
    required this.animation,
    required this.tanima,
    required this.onClear,
    required this.onAddPoint,
    required this.onEndLine,
    super.key,
  });

  final GlobalKey drawingAreaKey;
  final List<DrawingPoint?> points;
  final bool eraseMode;
  final Color selectedColor;
  final double strokeWidth;
  final bool showResult;
  final bool isLoading;
  final String recognitionResult;
  final Animation<double> animation;
  final String tanima;
  final VoidCallback onClear;
  final void Function(DrawingPoint) onAddPoint;
  final VoidCallback onEndLine;

  @override
  Widget build(BuildContext context) {
    // Ekran boyutuna göre çizim alanı boyutlarını hesapla
    final drawingSize = AppSizes.drawingAreaSize(context);

    return Center(
      child: Stack(
        children: [
          // Ana çizim alanı
          Container(
            key: drawingAreaKey,
            width: drawingSize,
            height: drawingSize,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppRadii.cardRadius(context)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadii.cardRadius(context)),
              child: Semantics(
                label:
                    DrawLocalizations.of(context)?.drawSemanticDrawingCanvas ??
                    'Drawing area',
                child: GestureDetector(
                  onPanStart: (details) {
                    if (showResult) return;
                    final renderBox =
                        drawingAreaKey.currentContext!.findRenderObject()!
                            as RenderBox;
                    final localPosition =
                        renderBox.globalToLocal(details.globalPosition);
                    final normalizedPosition =
                        localPosition * (280 / drawingSize);

                    onAddPoint(
                      DrawingPoint(
                        point: normalizedPosition,
                        paint: Paint()
                          ..color = eraseMode ? Colors.white : selectedColor
                          ..strokeCap = StrokeCap.round
                          ..strokeWidth = strokeWidth
                          ..isAntiAlias = true,
                      ),
                    );
                  },
                  onPanUpdate: (details) {
                    if (showResult) return;
                    final renderBox =
                        drawingAreaKey.currentContext!.findRenderObject()!
                            as RenderBox;
                    final localPosition =
                        renderBox.globalToLocal(details.globalPosition);
                    final normalizedPosition =
                        localPosition * (280 / drawingSize);

                    onAddPoint(
                      DrawingPoint(
                        point: normalizedPosition,
                        paint: Paint()
                          ..color = eraseMode ? Colors.white : selectedColor
                          ..strokeCap = StrokeCap.round
                          ..strokeWidth = strokeWidth
                          ..isAntiAlias = true,
                      ),
                    );
                  },
                  onTapDown: (details) {
                    if (showResult) return;
                    final renderBox =
                        drawingAreaKey.currentContext!.findRenderObject()!
                            as RenderBox;
                    final localPosition =
                        renderBox.globalToLocal(details.globalPosition);
                    final normalizedPosition =
                        localPosition * (280 / drawingSize);

                    onAddPoint(
                      DrawingPoint(
                        point: normalizedPosition,
                        paint: Paint()
                          ..color = eraseMode ? Colors.white : selectedColor
                          ..strokeCap = StrokeCap.round
                          ..strokeWidth = strokeWidth
                          ..isAntiAlias = true,
                      ),
                    );
                    onEndLine();
                  },
                  onPanEnd: (_) {
                    if (showResult) return;
                    onEndLine();
                  },
                  // ✅ RepaintBoundary: CustomPainter'ı ana ağaçtan izole eder
                  // (16_performance.md §"Widget Performance Rules")
                  child: RepaintBoundary(
                    child: CustomPaint(
                      painter: DrawingPainter(
                        pointsList: points,
                        pointsLength: points.length,
                      ),
                      size: Size(drawingSize, drawingSize),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Sonuç overlay'i — showResult true ise göster
          if (showResult)
            Positioned.fill(
              child: Center(
                child: ScaleTransition(
                  scale: animation,
                  child: Container(
                    width: drawingSize,
                    height: drawingSize,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.85),
                      borderRadius:
                          BorderRadius.circular(AppRadii.cardRadius(context)),
                      border: Border.all(
                        color: ColorScheme.of(context).tertiary,
                        width: 3,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DrawLocalizations.of(context)?.drawPredictionResult ?? 'Prediction Result:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: drawingSize * 0.14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: drawingSize * 0.08),
                        Container(
                          width: drawingSize * 0.7,
                          height: drawingSize * 0.7,
                          decoration: BoxDecoration(
                            color: ColorScheme.of(context).tertiary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: ColorScheme.of(context).tertiary
                                    .withValues(alpha: 0.5),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                recognitionResult,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: drawingSize * 0.3,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: drawingSize * 0.08),
                        ElevatedButton(
                          onPressed: onClear,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorScheme.of(context).tertiary,
                            foregroundColor: Colors.white,
                            elevation: 5,
                            padding: EdgeInsets.symmetric(
                              horizontal: drawingSize * 0.1,
                              vertical: drawingSize * 0.04,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(drawingSize * 0.1),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.refresh, size: drawingSize * 0.06),
                              const SizedBox(width: 8),
                              Text(
                                DrawLocalizations.of(context)?.drawRedraw ?? 'Redraw',
                                style: TextStyle(
                                  fontSize: drawingSize * 0.06,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Yükleme indikatörü
          if (isLoading)
            Positioned.fill(
              child: ColoredBox(
                color: Colors.black.withValues(alpha: 0.5),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: drawingSize * 0.15,
                        height: drawingSize * 0.15,
                        child: CircularProgressIndicator(
                          strokeWidth: drawingSize * 0.015,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            ColorScheme.of(context).tertiary,
                          ),
                        ),
                      ),
                      SizedBox(height: drawingSize * 0.07),
                      Text(
                        DrawLocalizations.of(context)?.drawIdentifying ?? 'Identifying...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: drawingSize * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// DrawingPainter sınıfı — CustomPainter (`16_performance.md` §"Widget Performance").
///
/// `shouldRepaint`: nokta listesi değiştiğinde repaint yapılır;
/// aynı referans veya eşit liste olduğunda gereksiz repaint önlenir.
class DrawingPainter extends CustomPainter {
  const DrawingPainter({required this.pointsList, required this.pointsLength});

  final List<DrawingPoint?> pointsList;
  final int pointsLength;

  @override
  void paint(Canvas canvas, Size size) {
    final scaleX = size.width / 280.0;
    final scaleY = size.height / 280.0;

    for (var i = 0; i < pointsList.length - 1; i++) {
      final current = pointsList[i];
      final next = pointsList[i + 1];

      if (current != null && next != null) {
        canvas.drawLine(
          Offset(current.point.dx * scaleX, current.point.dy * scaleY),
          Offset(next.point.dx * scaleX, next.point.dy * scaleY),
          current.paint,
        );
      } else if (current != null && next == null) {
        canvas.drawCircle(
          Offset(current.point.dx * scaleX, current.point.dy * scaleY),
          current.paint.strokeWidth / 2,
          current.paint,
        );
      }
    }

    // Son nokta kontrolü
    if (pointsList.isNotEmpty && pointsList.last != null) {
      final last = pointsList.last!;
      canvas.drawCircle(
        Offset(last.point.dx * scaleX, last.point.dy * scaleY),
        last.paint.strokeWidth / 2,
        last.paint,
      );
    }
  }

  /// ✅ Gerçek değişiklik kontrolü — aynı liste referansında repaint yok.
  /// (16_performance.md §"Widget Performance Rules")
  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) =>
      oldDelegate.pointsLength != pointsLength;
}

/// Çizim noktası veri sınıfı.
class DrawingPoint {
  const DrawingPoint({required this.point, required this.paint});

  final Offset point;
  final Paint paint;
}
