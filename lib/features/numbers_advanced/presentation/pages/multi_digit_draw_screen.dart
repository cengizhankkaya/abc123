import 'package:abc123/features/draw/presentation/widgets/action_toolbar_widget.dart';
import 'package:abc123/features/numbers_advanced/l10n/l10n_extensions.dart';
import 'package:abc123/features/numbers_advanced/presentation/providers/math_progress_provider.dart';
import 'package:abc123/features/numbers_advanced/presentation/widgets/digit_box_widget.dart';
import 'package:abc123/features/numbers_advanced/presentation/widgets/math_result_overlay.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MultiDigitDrawScreen extends StatefulWidget {
  const MultiDigitDrawScreen({
    required this.isFreePractice,
    super.key,
  });

  final bool isFreePractice;

  @override
  State<MultiDigitDrawScreen> createState() => _MultiDigitDrawScreenState();
}

class _MultiDigitDrawScreenState extends State<MultiDigitDrawScreen> {
  final GlobalKey _hundredsKey = GlobalKey();
  final GlobalKey _tensKey = GlobalKey();
  final GlobalKey _unitsKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final l10n = context.mathL10n;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF6C63FF)),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              widget.isFreePractice
                  ? const Color(0xFFE17055).withOpacity(0.1)
                  : const Color(0xFF00CEC9).withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Consumer<MathProgressProvider>(
            builder: (context, provider, _) {
              final targetNumber = widget.isFreePractice
                  ? provider.currentFreeNumber
                  : provider.currentLesson?.targetNumber ?? 10;
              
              final isCorrect = provider.lastAnswerCorrect;
              final isLoading = provider.isLoading;
              
              // Hedef sayının haneleri
              final isTripleDigit = targetNumber >= 100;
              final hundredsDigit = isTripleDigit ? targetNumber ~/ 100 : 0;
              final tensDigit = isTripleDigit ? (targetNumber ~/ 10) % 10 : targetNumber ~/ 10;
              final unitsDigit = targetNumber % 10;
              final boxSize = isTripleDigit ? 130.0 : 170.0;

              return Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          widget.isFreePractice 
                              ? l10n.mathFreePracticeInstruction(targetNumber)
                              : l10n.mathDrawTensInstruction(targetNumber),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3436),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Çizim Alanı
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isTripleDigit) ...[
                                // Yüzler Kutusu
                                DigitBoxWidget(
                                  boxKey: _hundredsKey,
                                  boxIndex: 2,
                                  label: "Yüzler",
                                  isActive: provider.activeBox == 2,
                                  points: provider.hundredsPoints,
                                  hintText: provider.hintEnabled ? hundredsDigit.toString() : null,
                                  size: boxSize,
                                  onTap: () => provider.setActiveBox(2),
                                ),
                                const SizedBox(width: 12),
                              ],
                              // Onlar Kutusu
                              DigitBoxWidget(
                                boxKey: _tensKey,
                                boxIndex: 0,
                                label: l10n.mathTensBox,
                                isActive: provider.activeBox == 0,
                                points: provider.tensPoints,
                                hintText: provider.hintEnabled ? tensDigit.toString() : null,
                                size: boxSize,
                                onTap: () => provider.setActiveBox(0),
                              ),
                              SizedBox(width: isTripleDigit ? 12 : 20),
                              // Birler Kutusu
                              DigitBoxWidget(
                                boxKey: _unitsKey,
                                boxIndex: 1,
                                label: l10n.mathUnitsBox,
                                isActive: provider.activeBox == 1,
                                points: provider.unitsPoints,
                                hintText: provider.hintEnabled ? unitsDigit.toString() : null,
                                size: boxSize,
                                onTap: () => provider.setActiveBox(1),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Kontrol Butonu
                      if (isCorrect == null && !isLoading)
                        ElevatedButton(
                          onPressed: () {
                            if (isTripleDigit) {
                              if (provider.hundredsPoints.isEmpty && provider.tensPoints.isEmpty && provider.unitsPoints.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(l10n.mathEmptyDrawingWarning)),
                                );
                                return;
                              }
                            } else {
                              if (provider.tensPoints.isEmpty && provider.unitsPoints.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(l10n.mathEmptyDrawingWarning)),
                                );
                                return;
                              }
                            }
                            provider.evaluateMultiDigit(
                              hundredsKey: isTripleDigit ? _hundredsKey : null,
                              tensKey: _tensKey,
                              unitsKey: _unitsKey,
                              expectedResult: targetNumber,
                              type: widget.isFreePractice ? MathType.free : MathType.tens,
                              context: context,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C63FF),
                            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            l10n.mathCheckButton,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        
                      if (isLoading)
                        const CircularProgressIndicator(color: Color(0xFF6C63FF)),
                        
                      const Spacer(),
                      
                      // Alt Araç Çubuğu
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => provider.clearActiveBox(),
                              icon: const Icon(Icons.delete_outline, color: Colors.white),
                              label: Text(
                                l10n.mathClearButton,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  // Sonuç Overlay
                  if (isCorrect != null)
                    MathResultOverlay(
                      isCorrect: isCorrect,
                      onNext: () {
                        if (widget.isFreePractice) {
                          provider.startFreePractice();
                        } else {
                          // Onluklar modunda seçim ekranına dön
                          context.pop();
                        }
                      },
                      onRetry: () {
                        provider.startTensLesson(targetNumber); // State'i sıfırlar
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
