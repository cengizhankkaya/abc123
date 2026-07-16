import 'package:abc123/features/ar/domain/ar_model_mapper.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

/// AR görüntüleme ekranı.
///
/// [letter] parametresi ile ilgili harfin 3D modeli gösterilir.
/// Cihaz AR'ı destekliyorsa "AR'da Aç" butonu ile gerçek dünyada görüntülenebilir.
class ArViewerScreen extends StatelessWidget {
  const ArViewerScreen({
    required this.letter,
    super.key,
  });

  final String letter;

  @override
  Widget build(BuildContext context) {
    final modelInfo = ArModelMapper.forLetter(letter);

    if (modelInfo == null) {
      return _ArNotAvailableScreen(letter: letter);
    }

    return _ArModelView(letter: letter, modelInfo: modelInfo);
  }
}

// ─────────────────── AR Model Görünümü ───────────────────

class _ArModelView extends StatelessWidget {
  const _ArModelView({
    required this.letter,
    required this.modelInfo,
  });

  final String letter;
  final ArModelInfo modelInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              modelInfo.emoji,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 8),
            Text(
              modelInfo.displayName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                shadows: [
                  Shadow(
                    color: Colors.black38,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient arka plan
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1a1a2e),
                  Color(0xFF16213e),
                  Color(0xFF0f3460),
                ],
              ),
            ),
          ),

          // 3D Model Görüntüleyici
          ModelViewer(
            src: modelInfo.assetPath,
            alt: '${modelInfo.displayName} 3D modeli',
            ar: true,
            arModes: const ['scene-viewer', 'webxr', 'quick-look'],
            autoRotate: true,
            autoRotateDelay: 0,
            rotationPerSecond: '30deg',
            cameraControls: true,
            shadowIntensity: 1,
            shadowSoftness: 1,
            exposure: 1,
            backgroundColor: Colors.transparent,
          ),

          // Alt bilgi paneli - sol altta kompak olarak yüzüyor, böylece 3D model ve sağ alttaki AR butonu kapanmıyor
          Positioned(
            bottom: 16,
            left: 16,
            child: _BottomInfoPanel(letter: letter, modelInfo: modelInfo),
          ),
        ],
      ),
    );
  }
}

// ─────────────────── Alt Bilgi Paneli ───────────────────

class _BottomInfoPanel extends StatelessWidget {
  const _BottomInfoPanel({
    required this.letter,
    required this.modelInfo,
  });

  final String letter;
  final ArModelInfo modelInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.45,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF16213e).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Harf gösterimi
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white54, width: 2),
            ),
            child: Center(
              child: Text(
                letter.toUpperCase(),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Model bilgisi
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${modelInfo.emoji}  ${modelInfo.displayName}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '👆 Döndürmek için sürükle!\n📦 Odanda görmek için sağ alttaki AR butonuna bas.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────── Model Yoksa Gösterilen Ekran ───────────────────

class _ArNotAvailableScreen extends StatelessWidget {
  const _ArNotAvailableScreen({required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🔭', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 24),
            Text(
              '"$letter" harfi için\nhenüz 3D model yok',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Yakında eklenecek! 🎉',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
