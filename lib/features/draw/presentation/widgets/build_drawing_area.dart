import 'package:abc123/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_radii.dart';

/// Çizim alanını oluşturan widget
Widget buildDrawingArea(
  Size size,
  GlobalKey drawingAreaKey,
  List<DrawingPoint?> points,
  bool eraseMode,
  Color selectedColor,
  double strokeWidth,
  bool showResult,
  bool isLoading,
  String recognitionResult,
  Animation<double> animation,
  String tanima,
  void Function() clearDrawing,
  void Function(DrawingPoint) onAddPoint,
  void Function() onEndLine,
  BuildContext context,
) {
  // Ekran boyutuna göre çizim alanı boyutlarını hesapla
  final double drawingSize = AppSizes.drawingAreaSize(context);

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
            child: GestureDetector(
              onPanStart: (details) {
                if (showResult) return;
                final RenderBox renderBox = drawingAreaKey.currentContext
                    ?.findRenderObject() as RenderBox;

                // Çizim alanı içindeki tam konumu hesapla
                final Offset localPosition =
                    renderBox.globalToLocal(details.globalPosition);
                // Pozisyonu normalize et
                final Offset normalizedPosition =
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
                final RenderBox renderBox = drawingAreaKey.currentContext
                    ?.findRenderObject() as RenderBox;

                // Çizim alanı içindeki tam konumu hesapla
                final Offset localPosition =
                    renderBox.globalToLocal(details.globalPosition);
                // Pozisyonu normalize et
                final Offset normalizedPosition =
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
              onTapDown: (TapDownDetails details) {
                if (showResult) return;
                final RenderBox renderBox = drawingAreaKey.currentContext
                    ?.findRenderObject() as RenderBox;

                // Çizim alanı içindeki tam konumu hesapla
                final Offset localPosition =
                    renderBox.globalToLocal(details.globalPosition);
                // Pozisyonu normalize et
                final Offset normalizedPosition =
                    localPosition * (280 / drawingSize);

                // Tek noktada çizim için aynı konuma iki nokta ekle
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
              onPanEnd: (details) {
                if (showResult) return;
                onEndLine();
              },
              child: CustomPaint(
                painter: DrawingPainter(pointsList: points),
                size: Size(drawingSize, drawingSize),
              ),
            ),
          ),
        ),

        // Sonuç overlay'i - eğer showResult true ise göster
        if (showResult)
          Positioned.fill(
            child: Center(
              child: ScaleTransition(
                scale: animation,
                child: Container(
                  width: drawingSize,
                  height: drawingSize,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.85),
                    borderRadius:
                        BorderRadius.circular(AppRadii.cardRadius(context)),
                    border: Border.all(
                      color: AppColors.accentColor,
                      width: 3,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tahmin Sonucu:",
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
                          color: AppColors.accentColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accentColor.withOpacity(0.5),
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
                        onPressed: clearDrawing,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentColor,
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
                            SizedBox(width: 8),
                            Text(
                              "Tekrar Çiz",
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
            child: Container(
              color: Colors.black.withOpacity(0.5),
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
                            AppColors.accentColor),
                      ),
                    ),
                    SizedBox(height: drawingSize * 0.07),
                    Text(
                      "Tanımlanıyor...",
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

/// DrawingPainter sınıfı - çizimi yapan CustomPainter
class DrawingPainter extends CustomPainter {
  final List<DrawingPoint?> pointsList;

  DrawingPainter({required this.pointsList});

  @override
  void paint(Canvas canvas, Size size) {
    // Ekran boyutuna göre ölçeklendirme için hazırlık
    final double scaleX = size.width / 280.0;
    final double scaleY = size.height / 280.0;

    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        // Çizgi çiz - ölçeklendirilmiş koordinatlar
        canvas.drawLine(
          Offset(pointsList[i]!.point.dx * scaleX,
              pointsList[i]!.point.dy * scaleY),
          Offset(pointsList[i + 1]!.point.dx * scaleX,
              pointsList[i + 1]!.point.dy * scaleY),
          pointsList[i]!.paint,
        );
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        // Nokta çiz - ölçeklendirilmiş koordinatlar
        canvas.drawCircle(
          Offset(pointsList[i]!.point.dx * scaleX,
              pointsList[i]!.point.dy * scaleY),
          pointsList[i]!.paint.strokeWidth / 2,
          pointsList[i]!.paint,
        );
      }
    }

    // Son nokta kontrolü (eğer liste boş değilse ve son eleman null değilse)
    if (pointsList.isNotEmpty && pointsList.last != null) {
      canvas.drawCircle(
        Offset(pointsList.last!.point.dx * scaleX,
            pointsList.last!.point.dy * scaleY),
        pointsList.last!.paint.strokeWidth / 2,
        pointsList.last!.paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Çizim noktası sınıfı
class DrawingPoint {
  final Offset point;
  final Paint paint;

  DrawingPoint({required this.point, required this.paint});
}
