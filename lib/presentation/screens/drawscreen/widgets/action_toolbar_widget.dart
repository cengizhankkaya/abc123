import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/language_provider.dart';
import 'package:abc123/core/constants/language_constants.dart';

class ActionToolbarWidget extends StatelessWidget {
  final VoidCallback onClear;
  final VoidCallback onPenMode;
  final VoidCallback onEraseMode;
  final VoidCallback onRecognize;
  final bool eraseMode;
  final Color selectedColor;
  final bool showResult;
  final bool isLoading;
  final bool isSequentialModeActive;
  final Function(bool) onSequentialModeChanged;
  final int correctlyDrawnCount;
  final int totalAttempts;

  const ActionToolbarWidget({
    super.key,
    required this.onClear,
    required this.onPenMode,
    required this.onEraseMode,
    required this.onRecognize,
    required this.eraseMode,
    required this.selectedColor,
    required this.showResult,
    required this.isLoading,
    required this.isSequentialModeActive,
    required this.onSequentialModeChanged,
    required this.correctlyDrawnCount,
    required this.totalAttempts,
  });

  Widget _buildActionButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onTap,
    ResponsiveSize responsive,
    bool isSelected,
  ) {
    final double buttonFontSize =
        ((responsive.width + responsive.height) * 0.008).clamp(10.0, 18.0);
    final double buttonIconSize =
        ((responsive.width + responsive.height) * 0.008).clamp(12.0, 20.0);
    final double buttonHPadding = responsive.width * 0.03;
    final double buttonVPadding = responsive.height * 0.018;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: buttonHPadding,
          vertical: buttonVPadding,
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(0.9),
          borderRadius: BorderRadius.circular(responsive.width * 0.01),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 6,
                spreadRadius: 0.5,
                offset: Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: buttonFontSize,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            SizedBox(width: responsive.tinyPadding),
            Icon(
              icon,
              size: buttonIconSize,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);
    final lang = context.watch<LanguageProvider>().language;
    final texts = localizedActionToolbarTexts[lang] ??
        localizedActionToolbarTexts[AppLanguage.english]!;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.panelColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            spreadRadius: 0.5,
            offset: Offset(0, -1),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: responsive.sidePadding * 0.9,
        vertical: responsive.height * 0.009,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: responsive.sidePadding * 0.9,
        vertical: responsive.verticalPadding * 0.5,
      ),
      height: responsive.height * 0.08,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Text(
                  texts['sequentialMode'] as String,
                  style: TextStyle(
                    fontSize: ((responsive.width + responsive.height) * 0.007)
                        .clamp(9.0, 15.0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Transform.scale(
                  scale: 0.4,
                  child: Switch(
                    value: isSequentialModeActive,
                    onChanged: onSequentialModeChanged,
                    activeColor: Colors.green,
                  ),
                ),
                if (isSequentialModeActive)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        (texts['correctTotal'] as dynamic)(
                            correctlyDrawnCount, totalAttempts) as String,
                        style: TextStyle(
                          fontSize:
                              ((responsive.width + responsive.height) * 0.008)
                                  .clamp(10.0, 16.0),
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildActionButton(
                  texts['clear'] as String,
                  Icons.delete_outline,
                  Colors.grey.shade300,
                  onClear,
                  responsive,
                  false,
                ),
                SizedBox(width: responsive.width * 0.008),
                _buildActionButton(
                  texts['pen'] as String,
                  Icons.edit,
                  Colors.black,
                  onPenMode,
                  responsive,
                  !eraseMode && selectedColor == Colors.black,
                ),
                SizedBox(width: responsive.width * 0.008),
                _buildActionButton(
                  texts['eraser'] as String,
                  Icons.cleaning_services_outlined,
                  Colors.yellow.shade200,
                  onEraseMode,
                  responsive,
                  eraseMode,
                ),
                SizedBox(width: responsive.width * 0.008),
                _buildActionButton(
                  texts['recognize'] as String,
                  Icons.arrow_forward_ios,
                  AppColors.secondaryColor,
                  onRecognize,
                  responsive,
                  false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
