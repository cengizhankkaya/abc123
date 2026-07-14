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
    return Consumer<MathProgressProvider>(
      builder: (context, provider, _) {
        return _MultiDigitDrawView(
          isFreePractice: widget.isFreePractice,
          provider: provider,
          hundredsKey: _hundredsKey,
          tensKey: _tensKey,
          unitsKey: _unitsKey,
        );
      },
    );
  }
}

class _MultiDigitDrawView extends StatelessWidget {
  const _MultiDigitDrawView({
    required this.isFreePractice,
    required this.provider,
    required this.hundredsKey,
    required this.tensKey,
    required this.unitsKey,
  });

  final bool isFreePractice;
  final MathProgressProvider provider;
  final GlobalKey hundredsKey;
  final GlobalKey tensKey;
  final GlobalKey unitsKey;

  @override
  Widget build(BuildContext context) {
    final targetNumber = isFreePractice
        ? provider.currentFreeNumber
        : provider.currentLesson?.targetNumber ?? 10;
        
    final isCorrect = provider.lastAnswerCorrect;

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
              if (isFreePractice) const Color(0xFFE17055).withValues(alpha: 0.1) else const Color(0xFF00CEC9).withValues(alpha: 0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  _InstructionText(
                    isFreePractice: isFreePractice,
                    targetNumber: targetNumber,
                  ),
                  const Spacer(),
                  _DrawingBoxesArea(
                    provider: provider,
                    targetNumber: targetNumber,
                    hundredsKey: hundredsKey,
                    tensKey: tensKey,
                    unitsKey: unitsKey,
                  ),
                  const SizedBox(height: 32),
                  if (isCorrect == null && !provider.isLoading)
                    _CheckButton(
                      provider: provider,
                      isFreePractice: isFreePractice,
                      targetNumber: targetNumber,
                      hundredsKey: hundredsKey,
                      tensKey: tensKey,
                      unitsKey: unitsKey,
                    ),
                  if (provider.isLoading)
                    const CircularProgressIndicator(color: Color(0xFF6C63FF)),
                  const Spacer(),
                  _ClearButton(provider: provider),
                ],
              ),
              if (isCorrect != null)
                MathResultOverlay(
                  isCorrect: isCorrect,
                  onNext: () {
                    if (isFreePractice) {
                      provider.startFreePractice();
                    } else {
                      context.pop();
                    }
                  },
                  onRetry: () {
                    provider.startTensLesson(targetNumber);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstructionText extends StatelessWidget {
  const _InstructionText({
    required this.isFreePractice,
    required this.targetNumber,
  });

  final bool isFreePractice;
  final int targetNumber;

  @override
  Widget build(BuildContext context) {
    final l10n = context.mathL10n;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        isFreePractice
            ? l10n.mathFreePracticeInstruction(targetNumber)
            : l10n.mathDrawTensInstruction(targetNumber),
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2D3436),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _DrawingBoxesArea extends StatelessWidget {
  const _DrawingBoxesArea({
    required this.provider,
    required this.targetNumber,
    required this.hundredsKey,
    required this.tensKey,
    required this.unitsKey,
  });

  final MathProgressProvider provider;
  final int targetNumber;
  final GlobalKey hundredsKey;
  final GlobalKey tensKey;
  final GlobalKey unitsKey;

  @override
  Widget build(BuildContext context) {
    final l10n = context.mathL10n;
    final isTripleDigit = targetNumber >= 100;
    final hundredsDigit = isTripleDigit ? targetNumber ~/ 100 : 0;
    final tensDigit = isTripleDigit ? (targetNumber ~/ 10) % 10 : targetNumber ~/ 10;
    final unitsDigit = targetNumber % 10;
    final boxSize = isTripleDigit ? 130.0 : 170.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isTripleDigit) ...[
              DigitBoxWidget(
                boxKey: hundredsKey,
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
            DigitBoxWidget(
              boxKey: tensKey,
              boxIndex: 0,
              label: l10n.mathTensBox,
              isActive: provider.activeBox == 0,
              points: provider.tensPoints,
              hintText: provider.hintEnabled ? tensDigit.toString() : null,
              size: boxSize,
              onTap: () => provider.setActiveBox(0),
            ),
            SizedBox(width: isTripleDigit ? 12 : 20),
            DigitBoxWidget(
              boxKey: unitsKey,
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
    );
  }
}

class _CheckButton extends StatelessWidget {
  const _CheckButton({
    required this.provider,
    required this.isFreePractice,
    required this.targetNumber,
    required this.hundredsKey,
    required this.tensKey,
    required this.unitsKey,
  });

  final MathProgressProvider provider;
  final bool isFreePractice;
  final int targetNumber;
  final GlobalKey hundredsKey;
  final GlobalKey tensKey;
  final GlobalKey unitsKey;

  @override
  Widget build(BuildContext context) {
    final l10n = context.mathL10n;
    final isTripleDigit = targetNumber >= 100;

    return ElevatedButton(
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
        } else {
          if (provider.tensPoints.isEmpty && provider.unitsPoints.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.mathEmptyDrawingWarning)),
            );
            return;
          }
        }
        provider.evaluateMultiDigit(
          hundredsKey: isTripleDigit ? hundredsKey : null,
          tensKey: tensKey,
          unitsKey: unitsKey,
          expectedResult: targetNumber,
          type: isFreePractice ? MathType.free : MathType.tens,
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
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({required this.provider});

  final MathProgressProvider provider;

  @override
  Widget build(BuildContext context) {
    final l10n = context.mathL10n;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: provider.clearActiveBox,
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
    );
  }
}
