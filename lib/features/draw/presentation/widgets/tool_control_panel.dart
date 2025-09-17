import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/utils/responsive_size.dart';
import 'package:abc123/features/draw/presentation/widgets/admob_banner_widget.dart';
import 'package:abc123/features/draw/presentation/widgets/build_color_button.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:abc123/core/constants/language_constants.dart';

import '../../../../shared/language_provider.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_radii.dart';

class ToolControlPanel extends StatelessWidget {
  final double strokeWidth;
  final bool eraseMode;
  final Color selectedColor;
  final List<Color> colors;
  final Function(double) onStrokeWidthChanged;
  final Function(Color) onColorChanged;
  final Function(bool) onEraseModeChanged;
  final String titleKey;
  final double volume;
  final Function(double) onVolumeChanged;

  const ToolControlPanel({
    super.key,
    required this.strokeWidth,
    required this.eraseMode,
    required this.selectedColor,
    required this.colors,
    required this.onStrokeWidthChanged,
    required this.onColorChanged,
    required this.onEraseModeChanged,
    required this.titleKey,
    required this.volume,
    required this.onVolumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);
    final lang = context.watch<LanguageProvider>().language;
    final texts = localizedToolControlPanelTexts[lang] ??
        localizedToolControlPanelTexts[AppLanguage.english]!;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSmall(context) * 0.001, // azaltıldı
        vertical: AppSizes.paddingSmall(context) * 0.001, // azaltıldı
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.panelColor,
          borderRadius: BorderRadius.circular(AppRadii.cardRadius(context)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Başlık ve Geri Butonu - Sol tarafta
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: responsive.tinyIconSize * 1.5,
                    color: AppColors.surfaceColor,
                  ),
                ),
                SizedBox(
                    width: AppSizes.paddingSmall(context) * 0.5), // azaltıldı
                Text(texts[titleKey] as String,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.headerFontSize,
                    )),
              ],
            ),
            //Ortada deneme reklamı kutusu
            AdmobBannerWidget(),
            // Kalem Rengi - Sağ tarafta
            Row(
              children: [
                Text(
                  texts['penColor'] as String,
                  style: TextStyle(
                    color: AppColors.surfaceColor,
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.subtitleFontSize,
                  ),
                ), // azaltıldı
                ...colors.map((color) => Padding(
                      padding: EdgeInsets.only(
                          right: responsive.tinyPadding * 0.5), // azaltıldı
                      child: BuildColorButton(
                        color: color,
                        size: responsive
                            .tinyIconSize, // largeIconSize yerine mediumIconSize kullanıldı
                        selectedColor: selectedColor,
                        eraseMode: eraseMode,
                        onTap: (color) {
                          onColorChanged(color);
                          onEraseModeChanged(false);
                        },
                      ),
                    )),
                Icon(
                  volume == 0.0 ? Icons.volume_off : Icons.volume_up,
                  color: AppColors.surfaceColor,
                  size: responsive
                      .tinyIconSize, // largeIconSize yerine mediumIconSize kullanıldı
                ),
                Container(
                  width: AppSizes.sliderWidth(context),
                  height: AppSizes.sliderHeight(context),
                  child: Slider(
                    value: volume,
                    min: 0.0,
                    max: 1.0,
                    onChanged: onVolumeChanged,
                    activeColor: AppColors.surfaceColor,
                    inactiveColor: AppColors.surfaceColor.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
