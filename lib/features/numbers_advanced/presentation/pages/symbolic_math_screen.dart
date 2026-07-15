import 'package:abc123/features/numbers_advanced/domain/math_difficulty.dart';
import 'package:abc123/features/numbers_advanced/l10n/l10n_extensions.dart';
import 'package:abc123/features/numbers_advanced/presentation/providers/math_progress_provider.dart';
import 'package:abc123/features/numbers_advanced/presentation/widgets/digit_box_widget.dart';
import 'package:abc123/features/numbers_advanced/presentation/widgets/math_result_overlay.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SymbolicMathScreen extends StatefulWidget {
  const SymbolicMathScreen({super.key});

  @override
  State<SymbolicMathScreen> createState() => _SymbolicMathScreenState();
}

class _SymbolicMathScreenState extends State<SymbolicMathScreen> {
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
              const Color(0xFF6C5CE7).withValues(alpha: 0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Consumer<MathProgressProvider>(
            builder: (context, provider, _) {
              final operation = provider.currentOperation;
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
                      // Seviye Seçici
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildLevelTab(
                                  context, provider, DifficultyLevel.levelA, l10n.mathLevelA),
                              _buildLevelTab(
                                  context, provider, DifficultyLevel.levelB, l10n.mathLevelB),
                              _buildLevelTab(
                                  context, provider, DifficultyLevel.levelC, l10n.mathLevelC),
                            ],
                          ),
                        ),
                      ),

                      const Spacer(),

                      // İşlem Metni
                      Text(
                        '${operation.operandA} ${operation.operator} ${operation.operandB} = ?',
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6C5CE7),
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

                      const SizedBox(height: 32),

                      // Kontrol Butonu
                      if (isCorrect == null && !isLoading)
                        ElevatedButton(
                          onPressed: () {
                            final type = operation.operator == '+'
                                ? MathType.addition
                                : MathType.subtraction;

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
                              type: type,
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
                        provider.startSymbolicOperation(
                          isAddition: operation.operator == '+',
                        );
                      },
                      onRetry: () {
                        provider.clearActiveBox();
                        provider.setActiveBox(isDoubleDigit ? 0 : 1);
                        provider.startSymbolicOperation(
                          isAddition: operation.operator == '+',
                        );
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

  Widget _buildLevelTab(
      BuildContext context, MathProgressProvider provider, DifficultyLevel level, String label) {
    final isSelected = provider.selectedLevel == level;
    final isLocked = !provider.canUnlockLevel(level);

    return GestureDetector(
      onTap: () {
        if (!isLocked) {
          provider.selectLevel(level);
          provider.startSymbolicOperation(
              isAddition: provider.currentOperation?.operator == '+' ?? true);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6C5CE7) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF6C5CE7) : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            if (isLocked) ...[
              const SizedBox(width: 8),
              const Icon(Icons.lock_rounded, color: Colors.grey, size: 18),
            ],
          ],
        ),
      ),
    );
  }
}
