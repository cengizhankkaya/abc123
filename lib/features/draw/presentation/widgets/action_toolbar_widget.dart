import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/utils/responsive_size.dart';
import 'package:abc123/shared/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abc123/core/constants/language_constants.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_radii.dart';

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

  double _optimizedFontSize(ResponsiveSize responsive) {
    // Ekran boyutuna göre 12-16 arası bir değer döndür
    return ((responsive.width + responsive.height) * 0.007).clamp(12.0, 16.0);
  }

  Widget _buildActionButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onTap,
    BuildContext context,
    bool isSelected,
  ) {
    final responsive = ResponsiveSize(context);
    final double buttonSize = (responsive.height).clamp(28.0, 44.0);
    final double iconSize = (responsive.height * 0.035).clamp(16.0, 26.0);
    final double buttonHPadding = (responsive.width * 0.01).clamp(6.0, 14.0);
    final double buttonVPadding = (responsive.height * 0.01).clamp(4.0, 10.0);
    final double borderRadius = (responsive.width * 0.02).clamp(10.0, 18.0);
    final Color backgroundColor =
        isSelected ? Colors.red : color.withOpacity(0.9);

    // Kalem butonu için ikon rengini ayarla
    bool isPenButton = icon == Icons.edit;
    Color iconColor;
    if (isPenButton) {
      iconColor = Colors.white;
    } else {
      iconColor = isSelected ? Colors.white : Colors.black87;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: buttonSize,
        height: buttonSize,
        padding: EdgeInsets.symmetric(
          horizontal: buttonHPadding,
          vertical: buttonVPadding,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: backgroundColor.withOpacity(0.5),
                blurRadius: 6,
                spreadRadius: 0.5,
                offset: Offset(0, 2),
              ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
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

    // Responsive yükseklik ve padding
    final double toolbarHeight = (responsive.height * 0.15).clamp(30.0, 30.0);
    final double buttonSpacing = (responsive.width * 0.01).clamp(10.0, 12.0);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingNormal(context) * 0.7,
        vertical: AppSizes.paddingSmall(context) * 0.08,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.panelColor,
          borderRadius: BorderRadius.circular(AppRadii.cardRadius(context)),
        ),
        height: toolbarHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.paddingNormal(context) * 0.7,
            vertical: AppSizes.paddingSmall(context) * 0.08,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Sıralı mod ve sayaç
              Flexible(
                flex: 2,
                child: Row(
                  children: [
                    Text(
                      texts['sequentialMode'] as String,
                      style: TextStyle(
                        fontSize: _optimizedFontSize(responsive),
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(width: buttonSpacing),
                    Transform.scale(
                      scale: 0.7,
                      child: Switch(
                        value: isSequentialModeActive,
                        onChanged: onSequentialModeChanged,
                        activeColor: Colors.green,
                      ),
                    ),
                    if (isSequentialModeActive)
                      Padding(
                        padding: EdgeInsets.only(left: buttonSpacing),
                        child: Text(
                          (texts['correctTotal'] as dynamic)(
                              correctlyDrawnCount, totalAttempts) as String,
                          style: TextStyle(
                            fontSize: _optimizedFontSize(responsive) * 0.95,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    Spacer(),
                    _buildActionButton(
                      '',
                      Icons.delete_outline,
                      Colors.grey.shade300,
                      onClear,
                      context,
                      false,
                    ),
                    SizedBox(width: buttonSpacing),
                    _buildActionButton(
                      '',
                      Icons.edit,
                      Colors.black,
                      onPenMode,
                      context,
                      !eraseMode && selectedColor == Colors.black,
                    ),
                    SizedBox(width: buttonSpacing),
                    _buildActionButton(
                      '',
                      Icons.cleaning_services_outlined,
                      Colors.yellow.shade200,
                      onEraseMode,
                      context,
                      eraseMode,
                    ),
                    SizedBox(width: buttonSpacing),
                    _buildActionButton(
                      '',
                      Icons.arrow_forward_ios,
                      AppColors.secondaryColor,
                      onRecognize,
                      context,
                      false,
                    ),
                  ],
                ),
              ),
              // Butonlar (Wrap ile responsive)
            ],
          ),
        ),
      ),
    );
  }
}
