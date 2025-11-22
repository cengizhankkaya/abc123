import 'dart:ui' as ui;

import 'package:abc123/core/constants/app_font_sizes.dart';
import 'package:abc123/core/constants/app_radii.dart';
import 'package:abc123/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class ShapesInfoScreen extends StatelessWidget {
  final ui.Image? drawingImage;
  final String recognizedShape;
  final String? targetShape;
  final bool isCorrect;

  const ShapesInfoScreen({
    super.key,
    required this.drawingImage,
    required this.recognizedShape,
    this.targetShape,
    this.isCorrect = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool success = isCorrect;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF3F51B5),
              Color(0xFF303F9F),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.paddingSmall(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Sol: Çizim
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: AppSizes.imageSize(context) * 0.9,
                        height: AppSizes.imageSize(context) * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            AppRadii.cardRadius(context),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: drawingImage != null
                            ? CustomPaint(
                                painter: _ShapesDrawingImagePainter(
                                  image: drawingImage!,
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Çizim bulunamadı',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            AppFontSizes.subtitle(context) * 0.5,
                                      ),
                                ),
                              ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Text(
                        'Çizdiğin Şekil',
                        style: TextStyle(
                          fontSize: AppFontSizes.title(context) * 0.4,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Orta ayırıcı
                Container(
                  height: size.height * 0.6,
                  width: 1,
                  color: Colors.white.withOpacity(0.3),
                  margin: EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingSmall(context),
                  ),
                ),
                // Sağ: Sonuç
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizes.paddingSmall(context),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          success ? 'Tebrikler!' : 'Tekrar Dene!',
                          style: TextStyle(
                            fontSize: AppFontSizes.title(context) * 0.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(0, 3),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          width: AppSizes.imageSize(context) * 0.55,
                          height: AppSizes.imageSize(context) * 0.55,
                          decoration: BoxDecoration(
                            color: success ? Colors.yellow : Colors.redAccent,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                recognizedShape,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      AppFontSizes.title(context) * 0.55,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (targetShape != null && !success)
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.02,
                              left: AppSizes.paddingLarge(context),
                              right: AppSizes.paddingLarge(context),
                            ),
                            child: Text(
                              'Hedef şekil: $targetShape',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:
                                    AppFontSizes.subtitle(context) * 0.42,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        SizedBox(height: size.height * 0.03),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingLarge(context),
                          ),
                          child: Text(
                            success
                                ? 'Bu şekli harika çizdin! Devam etmek için geri dönüp yeni şekiller deneyebilirsin.'
                                : 'Bu sefer olmadı. Aynı şekli tekrar çizmeyi dene, sonra yeniden deneyelim!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                                  AppFontSizes.subtitle(context) * 0.42,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.035),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color(0xFF303F9F),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05,
                              vertical: size.height * 0.015,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            'Geri Dön',
                            style: TextStyle(
                              fontSize: AppFontSizes.subtitle(context) * 0.48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShapesDrawingImagePainter extends CustomPainter {
  final ui.Image image;

  _ShapesDrawingImagePainter({required this.image});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final src = Rect.fromLTWH(
      0,
      0,
      image.width.toDouble(),
      image.height.toDouble(),
    );
    final dst = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(image, src, dst, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


