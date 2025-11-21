// ignore_for_file: deprecated_member_use
import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/constants/audio.dart';
import 'package:abc123/core/services/audio_service.dart';
import 'package:abc123/core/utils/responsive_size.dart';
import 'package:abc123/features/draw/presentation/widgets/action_toolbar_widget.dart';
import 'package:abc123/features/draw/presentation/widgets/build_drawing_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'shapes_drawing_provider.dart';

class ShapesDrawScreen extends StatefulWidget {
  const ShapesDrawScreen({super.key});

  @override
  State<ShapesDrawScreen> createState() => _ShapesDrawScreenState();
}

class _ShapesDrawScreenState extends State<ShapesDrawScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Ekranı yatay modda tut
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    AudioService().playBackground(AppAudios.happyKids);
  }

  @override
  void dispose() {
    _animationController.dispose();
    AudioService().stopBackground();

    // Dikey moda geri dön
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShapesDrawingProvider>(
      create: (_) => ShapesDrawingProvider(),
      child: Consumer<ShapesDrawingProvider>(
        builder: (context, provider, _) {
          final responsive = ResponsiveSize(context);

          // Şekiller için basit açıklama metni
          const String tanimaText = 'Bir şekil çizin (daire, kare veya üçgen)';

          // Çizim alanı key'i provider içinde tutuluyor
          final drawingAreaKey = provider.drawingAreaKey;

          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.backgroundColor,
                    AppColors.backgroundColor.withBlue(220),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Üst başlık
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Şekilleri Çiziyorum',
                        style: TextStyle(
                          fontSize: responsive.titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    // Çizim alanı
                    Expanded(
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: buildDrawingArea(
                            Size(responsive.width, responsive.height),
                            drawingAreaKey,
                            provider.points,
                            provider.eraseMode,
                            provider.selectedColor,
                            provider.strokeWidth,
                            provider.showResult,
                            provider.isLoading,
                            provider.recognitionResult,
                            _animation,
                            tanimaText,
                            () {
                              provider.clear();
                            },
                            (DrawingPoint point) {
                              provider.addPoint(point);
                            },
                            () {
                              provider.endLine();
                            },
                            context,
                          ),
                        ),
                      ),
                    ),
                    // Alt araç çubuğu
                    ActionToolbarWidget(
                      onClear: provider.clear,
                      onPenMode: () {
                        provider.setColor(Colors.black);
                        provider.setStrokeWidth(
                            responsive.mediumStrokeWidth.clamp(15.0, 35.0));
                        provider.setEraseMode(false);
                      },
                      onEraseMode: () {
                        provider.setEraseMode(true);
                        provider.setStrokeWidth(
                            responsive.eraserStrokeWidth.clamp(30.0, 60.0));
                      },
                      onRecognize: () async {
                        if (!provider.showResult && !provider.isLoading) {
                          await provider.recognizeShape(context);
                          if (provider.showResult) {
                            _animationController.reset();
                            _animationController.forward();
                          }
                        } else if (provider.showResult) {
                          provider.clear();
                        }
                      },
                      eraseMode: provider.eraseMode,
                      selectedColor: provider.selectedColor,
                      showResult: provider.showResult,
                      isLoading: provider.isLoading,
                      isSequentialModeActive: false,
                      onSequentialModeChanged: (_) {},
                      correctlyDrawnCount: 0,
                      totalAttempts: 0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


