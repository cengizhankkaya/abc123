import 'package:abc123/features/numbers_advanced/l10n/l10n_extensions.dart';
import 'package:abc123/features/numbers_advanced/presentation/providers/math_progress_provider.dart';
import 'package:abc123/features/numbers_advanced/presentation/widgets/digit_box_widget.dart';
import 'package:abc123/features/numbers_advanced/presentation/widgets/math_result_overlay.dart';
import 'package:abc123/features/numbers_advanced/presentation/widgets/object_count_display.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class VisualAdditionScreen extends StatefulWidget {
  const VisualAdditionScreen({super.key});

  @override
  State<VisualAdditionScreen> createState() => _VisualAdditionScreenState();
}

class _VisualAdditionScreenState extends State<VisualAdditionScreen> {
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
              const Color(0xFFFDCB6E).withValues(alpha: 0.2), // Yellow
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Consumer<MathProgressProvider>(
            builder: (context, provider, _) {
              final operation = provider.currentVisual;
              if (operation == null) return const SizedBox.shrink();

              final isCorrect = provider.lastAnswerCorrect;
              final isLoading = provider.isLoading;
              final result = operation.result;
              final isTripleDigit = result >= 100;
              final isDoubleDigit = result >= 10;
              final boxSize = isTripleDigit ? 130.0 : 170.0;
              final hundredsDigit = isTripleDigit ? result ~/ 100 : 0;
              final tensDigit = isTripleDigit ? (result ~/ 10) % 10 : operation.tensDigit;

              return Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          l10n.mathVisualInstruction,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3436),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // Görsel Toplama Gösterimi
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ObjectCountDisplay(
                                count: operation.operandA,
                                emoji: '🍎',
                                isCountingMode: provider.isCountingMode,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                '+',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6C63FF),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ObjectCountDisplay(
                                count: operation.operandB,
                                emoji: '🍎',
                                isCountingMode: provider.isCountingMode,
                                startIndex: operation.operandA,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          '=',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6C63FF),
                          ),
                        ),
                      ),

                      // Çizim Alanı
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isTripleDigit) ...[
                                DigitBoxWidget(
                                  boxKey: _hundredsKey,
                                  boxIndex: 2,
                                  label: 'Yüzler',
                                  isActive: provider.activeBox == 2,
                                  points: provider.hundredsPoints,
                                  hintText: provider.hintEnabled ? hundredsDigit.toString() : null,
                                  size: boxSize,
                                  onTap: () => provider.setActiveBox(2),
                                ),
                                const SizedBox(width: 12),
                              ],
                              if (isDoubleDigit) ...[
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
                              ],
                              DigitBoxWidget(
                                boxKey: _unitsKey,
                                boxIndex: 1,
                                label: isDoubleDigit ? l10n.mathUnitsBox : 'Sonuç',
                                isActive: provider.activeBox == 1,
                                points: provider.unitsPoints,
                                hintText:
                                    provider.hintEnabled ? operation.unitsDigit.toString() : null,
                                size: boxSize,
                                onTap: () => provider.setActiveBox(1),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Kontrol Butonu
                      if (isCorrect == null && !isLoading)
                        ElevatedButton(
                          onPressed: () {
                            if (isTripleDigit) {
                              if (provider.hundredsPoints.isEmpty &&
                                  provider.tensPoints.isEmpty &&
                                  provider.unitsPoints.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(l10n.mathEmptyDrawingWarning)),
                                );
                                return;
                              }
                            } else if (isDoubleDigit) {
                              if (provider.tensPoints.isEmpty && provider.unitsPoints.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(l10n.mathEmptyDrawingWarning)),
                                );
                                return;
                              }
                            } else {
                              if (provider.unitsPoints.isEmpty) {
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
                              expectedResult: result,
                              type: MathType.visual,
                              singleBox: !isDoubleDigit,
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

                      if (isLoading) const CircularProgressIndicator(color: Color(0xFF6C63FF)),

                      // Alt Araç Çubuğu
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24, top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => provider.clearActiveBox(),
                              icon: const Icon(Icons.delete_outline, color: Colors.white),
                              label: Text(
                                l10n.mathClearButton,
                                style: const TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold),
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
                        provider.startVisualAddition();
                      },
                      onRetry: () {
                        // Yanlış cevapta baştan başla (aynı soru) ama clear et
                        provider.clearActiveBox();
                        provider.setActiveBox(isDoubleDigit ? 0 : 1);
                        // _lastAnswerCorrect null olsun diye tekrar start veremeyiz
                        // provider'da clearLastAnswer() ekleyebilirim veya provider.startVisualAddition()'a parametre ekleyebilirim.
                        // Şimdilik yeniden başlatmak en temizi:
                        provider.startVisualAddition();
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
