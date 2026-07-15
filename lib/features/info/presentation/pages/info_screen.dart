import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:abc123/core/constants/app_font_sizes.dart';
import 'package:abc123/core/constants/app_radii.dart';
import 'package:abc123/core/constants/app_sizes.dart';
import 'package:abc123/core/presentation/orientation_helper.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/features/info/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:abc123/core/theme/theme_helper.dart';

// Ana uygulamanın main.dart dosyasında uygulamayı başlatırken bu kodu çağırın
void enforceInfoScreenOrientation() {
  // InfoScreen için yatay modu zorunlu kıl
  unawaited(OrientationHelper.setLandscape());
}

// InfoScreen artık bir sayfa olarak çalışacak ve çizimi gösterecek
class InfoScreen extends StatefulWidget {
  const InfoScreen({
    required this.drawingImage,
    required this.recognizedLetter,
    super.key,
  });
  final ui.Image? drawingImage;
  final String recognizedLetter;

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    super.initState();
    // Widget başlatıldığında ekranı yatay modda tut
    unawaited(OrientationHelper.setLandscape());
  }

  @override
  void dispose() {
    // Widget dispose olduğunda ekranı yine de yatay modda tut
    unawaited(OrientationHelper.setLandscape());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Yatay modu zorla
    unawaited(OrientationHelper.setLandscape());

    return _InfoView(
      drawingImage: widget.drawingImage,
      recognizedLetter: widget.recognizedLetter,
    );
  }
}

class _InfoView extends StatelessWidget {
  const _InfoView({
    required this.drawingImage,
    required this.recognizedLetter,
  });
  final ui.Image? drawingImage;
  final String recognizedLetter;

  @override
  Widget build(BuildContext context) {
    context.watch<LanguageProvider>();
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF3F51B5).withValues(alpha: 0.8),
              const Color(0xFF303F9F),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Konfeti arka plan
              const _ColorfulConfetti(),
              // Ana içerik - Yatay düzen (Landscape)
              Padding(
                padding: EdgeInsets.all(AppSizes.paddingSmall(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Sol bölüm - Çizim görüntüsü
                    Expanded(
                      flex: 2,
                      child: _DrawingPanel(drawingImage: drawingImage),
                    ),

                    // Orta ayırıcı
                    Container(
                      height: screenSize.height * 0.5,
                      width: 1,
                      color: Colors.white.withValues(alpha: 0.3),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                    ),

                    // Sağ bölüm - Metin ve buton
                    Expanded(
                      flex: 2,
                      child: _ResultPanel(recognizedLetter: recognizedLetter),
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

class _DrawingPanel extends StatelessWidget {
  const _DrawingPanel({required this.drawingImage});
  final ui.Image? drawingImage;

  @override
  Widget build(BuildContext context) {
    final i = context.infoL10n!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Çizim görüntüsü - çerçeve içinde
        Container(
          width: AppSizes.imageSize(context) * 0.8,
          height: AppSizes.imageSize(context) * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadii.cardRadius(context)),
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
                    i.infoDrawingNotFound,
                    style: TextStyle(
                      color: context.appColorScheme.outline,
                      fontSize: AppFontSizes.subtitle(context) * 0.4,
                    ),
                  ),
                ),
        ),
        Text(
          i.infoDrawnLetter,
          style: TextStyle(
            fontSize: AppFontSizes.title(context) * 0.4,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ResultPanel extends StatelessWidget {
  const _ResultPanel({required this.recognizedLetter});
  final String recognizedLetter;

  @override
  Widget build(BuildContext context) {
    final i = context.infoL10n!;
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonHorizontalPadding = screenWidth * 0.01;
    final buttonFontSize = screenWidth * 0.017;
    final buttonMaxWidth = screenWidth * 0.18;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSmall(context) * 0.003,
        vertical: AppSizes.paddingSmall(context) * 0.003,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tebrikler yazısı
          Text(
            i.infoCongrats,
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

          // Tanınan rakam
          Container(
            width: AppSizes.imageSize(context) * 0.4,
            height: AppSizes.imageSize(context) * 0.4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.yellow,
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
                recognizedLetter,
                style: TextStyle(
                  fontSize: AppFontSizes.title(context) * 0.4,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
          ),
          // Mesaj metni
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingLarge(context)),
            child: Text(
              i.infoSuccessMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppFontSizes.subtitle(context) * 0.4,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: buttonMaxWidth,
            ),
            child: ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF303F9F),
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: buttonHorizontalPadding,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
              child: Text(
                i.infoBack,
                style: TextStyle(
                  fontSize: buttonFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
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

    // Görüntüyü canvas'a çiz, boyutları ayarla
    final imageSize = Size(image.width.toDouble(), image.height.toDouble());
    final scale = size.width / imageSize.width;

    // Görüntüyü merkeze al ve ölçeklendir
    final offset = Offset(
      (size.width - imageSize.width * scale) / 2,
      (size.height - imageSize.height * scale) / 2,
    );

    canvas.scale(scale, scale);
    canvas.drawImage(image, offset, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _ColorfulConfetti extends StatelessWidget {
  const _ColorfulConfetti();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const confettiCount = 50;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSmall(context) * 0.003,
        vertical: AppSizes.paddingSmall(context) * 0.003,
      ),
      child: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        // color: Colors.transparent, // Kaldırıldı gereksiz
        child: Stack(
          children: List.generate(
            confettiCount,
            (index) {
              // Rastgele renk
              final color = Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
              // Rastgele şekil (kare, yıldız, daire)
              final shape = math.Random().nextInt(3);
              // Rastgele konum
              final left = math.Random().nextDouble() * screenSize.width;
              final top = math.Random().nextDouble() * screenSize.height;
              // Rastgele boyut
              final size = 5.0 + math.Random().nextDouble() * 10.0;

              return Positioned(
                left: left,
                top: top,
                child: Opacity(
                  opacity: 0.7,
                  child: shape == 0
                      ? Container(
                          width: size,
                          height: size,
                          color: color,
                        )
                      : shape == 1
                          ? Icon(
                              Icons.star,
                              color: color,
                              size: size,
                            )
                          : Container(
                              width: size,
                              height: size,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
