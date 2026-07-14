import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/constants/app_radii.dart';
import 'package:abc123/core/constants/app_sizes.dart';
import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/core/presentation/responsive/responsive_size.dart';
import 'package:abc123/features/draw/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionToolbarWidget extends StatelessWidget {

  const ActionToolbarWidget({
    required this.onClear, required this.onPenMode, required this.onEraseMode, required this.onRecognize, required this.eraseMode, required this.selectedColor, required this.showResult, required this.isLoading, required this.isSequentialModeActive, required this.onSequentialModeChanged, required this.correctlyDrawnCount, required this.totalAttempts, super.key,
    this.showSequentialControls = true,
    this.panelColor,
  });
  final VoidCallback onClear;
  final VoidCallback onPenMode;
  final VoidCallback onEraseMode;
  final VoidCallback onRecognize;
  final bool eraseMode;
  final Color selectedColor;
  final bool showResult;
  final bool isLoading;
  final bool isSequentialModeActive;
  final void Function(bool) onSequentialModeChanged;
  final int correctlyDrawnCount;
  final int totalAttempts;
  final bool showSequentialControls;
  final Color? panelColor;

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
    String semanticsLabel,
  ) {
    final responsive = ResponsiveSize(context);
    // Material minimum dokunma hedefi 48 dp (22_accessibility.md)
    final buttonSize = (responsive.height * 0.06).clamp(48.0, 56.0);
    final iconSize = (responsive.height * 0.035).clamp(16.0, 26.0);
    final buttonHPadding = (responsive.width * 0.01).clamp(6.0, 14.0);
    final buttonVPadding = (responsive.height * 0.01).clamp(4.0, 10.0);
    final borderRadius = (responsive.width * 0.02).clamp(10.0, 18.0);
    final backgroundColor = isSelected ? Colors.red : color.withValues(alpha: 0.9);

    // Kalem butonu için ikon rengini ayarla
    final isPenButton = icon == Icons.edit;
    Color iconColor;
    if (isPenButton) {
      iconColor = Colors.white;
    } else {
      iconColor = isSelected ? Colors.white : Colors.black87;
    }

    return Semantics(
      button: true,
      label: semanticsLabel,
      selected: isSelected,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
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
                color: backgroundColor.withValues(alpha: 0.5),
                blurRadius: 6,
                spreadRadius: 0.5,
                offset: const Offset(0, 2),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);
    context.watch<LanguageProvider>();
    final d = context.drawL10n!;

    // Responsive yükseklik ve padding
    final toolbarHeight =
        (responsive.height * 0.12).clamp(52.0, 64.0);
    final buttonSpacing = (responsive.width * 0.01).clamp(10.0, 12.0);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingNormal(context) * 0.7,
        vertical: AppSizes.paddingSmall(context) * 0.08,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: panelColor ?? AppColors.panelColor,
          borderRadius: BorderRadius.circular(AppRadii.cardRadius(context)),
        ),
        height: toolbarHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.paddingNormal(context) * 0.7,
            vertical: AppSizes.paddingSmall(context) * 0.08,
          ),
          child: Row(
            children: [
              if (showSequentialControls)
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                d.drawSequentialMode,
                                style: TextStyle(
                                  fontSize: _optimizedFontSize(responsive),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: buttonSpacing),
                              Transform.scale(
                                scale: 0.7,
                                child: Switch(
                                  value: isSequentialModeActive,
                                  onChanged: onSequentialModeChanged,
                                  activeThumbColor: Colors.green,
                                ),
                              ),
                              if (isSequentialModeActive)
                                Padding(
                                  padding: EdgeInsets.only(left: buttonSpacing),
                                  child: Text(
                                    d.drawCorrectTotal(correctlyDrawnCount, totalAttempts),
                                    style: TextStyle(
                                      fontSize: _optimizedFontSize(responsive) * 0.95,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      _buildActionButton(
                        '',
                        Icons.delete_outline,
                        Colors.grey.shade300,
                        onClear,
                        context,
                        false,
                        d.drawClear,
                      ),
                      SizedBox(width: buttonSpacing),
                      _buildActionButton(
                        '',
                        Icons.edit,
                        Colors.black,
                        onPenMode,
                        context,
                        !eraseMode && selectedColor == Colors.black,
                        d.drawPen,
                      ),
                      SizedBox(width: buttonSpacing),
                      _buildActionButton(
                        '',
                        Icons.cleaning_services_outlined,
                        Colors.yellow.shade200,
                        onEraseMode,
                        context,
                        eraseMode,
                        d.drawEraser,
                      ),
                      SizedBox(width: buttonSpacing),
                      _buildActionButton(
                        '',
                        Icons.arrow_forward_ios,
                        AppColors.secondaryColor,
                        onRecognize,
                        context,
                        false,
                        d.drawRecognize,
                      ),
                    ],
                  ),
                )
              else
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildActionButton(
                        '',
                        Icons.delete_outline,
                        Colors.grey.shade300,
                        onClear,
                        context,
                        false,
                        d.drawClear,
                      ),
                      SizedBox(width: buttonSpacing),
                      _buildActionButton(
                        '',
                        Icons.edit,
                        Colors.black,
                        onPenMode,
                        context,
                        !eraseMode && selectedColor == Colors.black,
                        d.drawPen,
                      ),
                      SizedBox(width: buttonSpacing),
                      _buildActionButton(
                        '',
                        Icons.cleaning_services_outlined,
                        Colors.yellow.shade200,
                        onEraseMode,
                        context,
                        eraseMode,
                        d.drawEraser,
                      ),
                      SizedBox(width: buttonSpacing),
                      _buildActionButton(
                        '',
                        Icons.arrow_forward_ios,
                        AppColors.secondaryColor,
                        onRecognize,
                        context,
                        false,
                        d.drawRecognize,
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
