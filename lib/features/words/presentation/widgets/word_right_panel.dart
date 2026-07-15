import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/constants/app_radii.dart';
import 'package:abc123/core/constants/app_sizes.dart';
import 'package:abc123/core/presentation/responsive/responsive_size.dart';
import 'package:abc123/features/draw/l10n/l10n_extensions.dart';
import 'package:abc123/features/words/presentation/widgets/word_target_display.dart';
import 'package:flutter/material.dart';

/// Sağ panel: puzzle yerine hedef kelime ve harf ilerlemesi.
class WordRightPanel extends StatelessWidget {
  const WordRightPanel({
    required this.emoji,
    required this.displayText,
    required this.spelling,
    required this.activeLetterIndex,
    required this.isLoading,
    super.key,
  });

  final String emoji;
  final String displayText;
  final String spelling;
  final int activeLetterIndex;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);
    final loadingText = context.drawL10n?.drawLetterPuzzlePreparing ?? '...';

    return Container(
      margin: EdgeInsets.only(
        right: AppSizes.paddingNormal(context) / 2,
        top: AppSizes.paddingSmall(context),
        bottom: AppSizes.paddingSmall(context),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadii.cardRadius(context)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: isLoading
            ? _buildLoading(responsive, loadingText)
            : LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth - 16,
                          maxHeight: constraints.maxHeight - 16,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: WordTargetDisplay(
                            emoji: emoji,
                            displayText: displayText,
                            spelling: spelling,
                            activeLetterIndex: activeLetterIndex,
                            compact: true,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildLoading(ResponsiveSize responsive, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(
          color: Color(0xFF00B894),
          strokeWidth: 4,
        ),
        SizedBox(height: responsive.height * 0.015),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: responsive.subtitleFontSize,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
