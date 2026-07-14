import 'dart:async';
import 'dart:ui' as ui;

import 'package:abc123/core/constants/app_font_sizes.dart';
import 'package:abc123/core/constants/app_radii.dart';
import 'package:abc123/core/constants/app_sizes.dart';
import 'package:abc123/core/constants/language_constants.dart';
import 'package:abc123/core/presentation/orientation_helper.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/features/info/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget {

  const ResultScreen({
    required this.drawingImage, required this.recognizedLetter, required this.targetLetter, required this.isCorrect, required this.onTryAgain, required this.onContinue, required this.correctCount, required this.totalAttempts, super.key,
  });
  final ui.Image? drawingImage;
  final String recognizedLetter;
  final dynamic targetLetter; // String olacak
  final bool isCorrect;
  final VoidCallback onTryAgain;
  final VoidCallback onContinue;
  final int correctCount;
  final int totalAttempts;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with TickerProviderStateMixin {
  late final AnimationController _confettiController;

  @override
  void initState() {
    super.initState();
    // Ekranı yatay modda tut
    unawaited(OrientationHelper.setLandscape());

    // Konfeti animasyonu için controller
    _confettiController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    if (widget.isCorrect) {
      _confettiController.forward();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ResultView(
      drawingImage: widget.drawingImage,
      recognizedLetter: widget.recognizedLetter,
      targetLetter: widget.targetLetter,
      isCorrect: widget.isCorrect,
      onTryAgain: widget.onTryAgain,
      onContinue: widget.onContinue,
      correctCount: widget.correctCount,
      totalAttempts: widget.totalAttempts,
    );
  }
}

class _ResultView extends StatelessWidget {

  const _ResultView({
    required this.drawingImage,
    required this.recognizedLetter,
    required this.targetLetter,
    required this.isCorrect,
    required this.onTryAgain,
    required this.onContinue,
    required this.correctCount,
    required this.totalAttempts,
  });
  final ui.Image? drawingImage;
  final String recognizedLetter;
  final dynamic targetLetter;
  final bool isCorrect;
  final VoidCallback onTryAgain;
  final VoidCallback onContinue;
  final int correctCount;
  final int totalAttempts;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final lang = context.watch<LanguageProvider>().language;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isCorrect
                ? [
                    const Color(0xFF4CAF50).withValues(alpha: 0.8),
                    const Color(0xFF388E3C),
                  ] // Doğru için yeşil
                : [
                    const Color(0xFFF44336).withValues(alpha: 0.8),
                    const Color(0xFFD32F2F),
                  ], // Yanlış için kırmızı
          ),
        ),
        child: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // --- DİL KODU ve BAYRAĞI GÖSTER ---
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _LanguageFlagPanel(lang: lang),
              ),
              // Ana içerik - Yatay düzen (Landscape)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingSmall(context) * 0.003,
                  vertical: AppSizes.paddingSmall(context) * 0.003,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Sol bölüm - Çizim görüntüsü
                    Expanded(
                      flex: 2,
                      child: _DrawingResultPanel(
                        drawingImage: drawingImage,
                        recognizedLetter: recognizedLetter,
                        isCorrect: isCorrect,
                      ),
                    ),

                    // Orta ayırıcı
                    Container(
                      height: screenSize.height * 0.5,
                      width: 1,
                      color: Colors.white.withValues(alpha: 0.3),
                      margin: EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingSmall(context) * 0.003,),
                    ),

                    // Sağ bölüm - Sonuç ve butonlar
                    Expanded(
                      flex: 3,
                      child: _ActionPanel(
                        targetLetter: targetLetter,
                        isCorrect: isCorrect,
                        correctCount: correctCount,
                        totalAttempts: totalAttempts,
                        onTryAgain: onTryAgain,
                        onContinue: onContinue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawingResultPanel extends StatelessWidget {

  const _DrawingResultPanel({
    required this.drawingImage,
    required this.recognizedLetter,
    required this.isCorrect,
  });
  final ui.Image? drawingImage;
  final String recognizedLetter;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    final i = context.infoL10n!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Çizim görüntüsü - çerçeve içinde
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: drawingImage != null
              ? CustomPaint(
                  painter: _DrawingImagePainter(image: drawingImage!),
                )
              : Center(
                  child: Text(
                    i.resultDrawingNotFound,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: AppFontSizes.subtitle(context) * 0.4,
                    ),
                  ),
                ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              i.resultDrawn,
              style: TextStyle(
                fontSize: AppFontSizes.subtitle(context) * 0.4,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingNormal(context) * 0.5,
                  vertical: AppSizes.paddingSmall(context) * 0.5,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadii.cardRadius(context)),
              ),
              child: Text(
                recognizedLetter,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ).copyWith(
                  color: isCorrect ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionPanel extends StatelessWidget {

  const _ActionPanel({
    required this.targetLetter,
    required this.isCorrect,
    required this.correctCount,
    required this.totalAttempts,
    required this.onTryAgain,
    required this.onContinue,
  });
  final dynamic targetLetter;
  final bool isCorrect;
  final int correctCount;
  final int totalAttempts;
  final VoidCallback onTryAgain;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final i = context.infoL10n!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Başlık yazısı
        Text(
          isCorrect ? i.resultCongrats : i.resultTryAgain,
          style: TextStyle(
            fontSize: AppFontSizes.title(context) * 0.4,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.3),
                offset: const Offset(0, 3),
                blurRadius: 5,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Hedef harf gösterimi
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              i.resultTargetLetter,
              style: TextStyle(
                fontSize: AppFontSizes.subtitle(context) * 0.4,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              width: AppSizes.imageSize(context) * 0.5,
              height: AppSizes.imageSize(context) * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  targetLetter.toString(),
                  style: TextStyle(
                    fontSize: AppFontSizes.title(context) * 0.4,
                    fontWeight: FontWeight.bold,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),

        // İlerleme ve istatistik bilgisi
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall(context) * 0.003),
          child: Column(
            children: [
              Text(
                isCorrect ? i.resultSuccessMessage : i.resultFailMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppFontSizes.subtitle(context) * 0.4,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),

              // İlerleme bilgisi
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 5),
                  Text(
                    i.resultProgress(
                      correctCount,
                      totalAttempts,
                    ),
                    style: TextStyle(
                      fontSize: AppFontSizes.subtitle(context) * 0.4,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Butonlar
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 20,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 120,
                maxWidth: MediaQuery.of(context).size.width * 0.25,
              ),
              child: ElevatedButton(
                onPressed: onTryAgain,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.grey[800],
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.015,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  i.resultTryAgainBtn,
                  style: TextStyle(
                    fontSize: AppFontSizes.subtitle(context) * 0.4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 120,
                maxWidth: MediaQuery.of(context).size.width * 0.25,
              ),
              child: ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: isCorrect ? Colors.green[600] : Colors.blue[600],
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.015,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  isCorrect ? i.resultNextLetter : i.resultNextLetterFail,
                  style: TextStyle(
                    fontSize: AppFontSizes.subtitle(context) * 0.4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Dil ve bayrak panelini ayrı bir widget olarak ekliyorum
class _LanguageFlagPanel extends StatelessWidget {
  const _LanguageFlagPanel({required this.lang});
  final AppLanguage lang;

  @override
  Widget build(BuildContext context) {
    final langOption = supportedLanguages.firstWhere(
      (l) => l.value == lang,
      orElse: () => supportedLanguages.first,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          langOption.flag,
          style: const TextStyle(fontSize: 28),
        ),
        const SizedBox(width: 8),
        Text(
          '${langOption.label} (${langOption.code})',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ).copyWith(
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.2),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Çizim görüntüsünü göstermek için CustomPainter
class _DrawingImagePainter extends CustomPainter {

  _DrawingImagePainter({required this.image});
  final ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // Resmi çiz
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
