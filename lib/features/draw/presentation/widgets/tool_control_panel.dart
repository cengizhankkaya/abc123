import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/presentation/responsive/responsive_size.dart';
import 'package:abc123/features/draw/presentation/widgets/admob_banner_widget.dart';
import 'package:abc123/features/draw/presentation/widgets/build_color_button.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:abc123/features/draw/l10n/generated/draw_localizations.dart';
import 'package:abc123/features/draw/l10n/l10n_extensions.dart';

import 'package:abc123/core/presentation/providers/language_provider.dart';
import 'package:abc123/core/constants/app_radii.dart';
import 'package:abc123/core/constants/app_sizes.dart';

String _penColorSemanticsLabel(DrawLocalizations d, Color color) {
  if (color == Colors.black) return d.drawSemanticPenColorBlack;
  if (color == Colors.red) return d.drawSemanticPenColorRed;
  if (color == Colors.blue) return d.drawSemanticPenColorBlue;
  if (color == Colors.yellow) return d.drawSemanticPenColorYellow;
  if (color == Colors.green) return d.drawSemanticPenColorGreen;
  if (color == Colors.purple) return d.drawSemanticPenColorPurple;
  if (color == Colors.orange) return d.drawSemanticPenColorOrange;
  return d.drawPenColor;
}

class ToolControlPanel extends StatelessWidget {
  final double strokeWidth;
  final bool eraseMode;
  final Color selectedColor;
  final List<Color> colors;
  final void Function(double) onStrokeWidthChanged;
  final void Function(Color) onColorChanged;
  final void Function(bool) onEraseModeChanged;
  final String titleKey;
  final double volume;
  final void Function(double) onVolumeChanged;
  final Color? panelColor;

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
    this.panelColor,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);
    context.watch<LanguageProvider>();
    final d = context.drawL10n!;
    final sectionTitle = switch (titleKey) {
      'letterTitle' => d.drawLetterSectionTitle,
      'shapeTitle' => d.drawShapeSectionTitle,
      _ => d.drawNumberSectionTitle,
    };

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingSmall(context) * 0.001, // azaltıldı
        vertical: AppSizes.paddingSmall(context) * 0.001, // azaltıldı
      ),
      child: Container(
        decoration: BoxDecoration(
          color: panelColor ?? AppColors.panelColor,
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
            Flexible(
              flex: 3,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: responsive.tinyIconSize * 1.5,
                      color: AppColors.surfaceColor,
                    ),
                  ),
                  SizedBox(width: AppSizes.paddingSmall(context) * 0.5), // azaltıldı
                  Text(sectionTitle,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.headerFontSize,
                      )),
                ],
              ),
            ),
            //Ortada deneme reklamı kutusu
            //Ortada deneme reklamı kutusu
            Center(child: AdmobBannerWidget(showTitle: true, isTitleSide: true)),
            // Kalem Rengi - Sağ tarafta
            Flexible(
              flex: 5,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      d.drawPenColor,
                      style: TextStyle(
                        color: AppColors.surfaceColor,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.subtitleFontSize,
                      ),
                    ), // azaltıldı
                    ...colors.map((color) => Padding(
                          padding:
                              EdgeInsets.only(right: responsive.tinyPadding * 0.5), // azaltıldı
                          child: BuildColorButton(
                            color: color,
                            size: responsive
                                .tinyIconSize, // largeIconSize yerine mediumIconSize kullanıldı
                            selectedColor: selectedColor,
                            eraseMode: eraseMode,
                            semanticsLabel: _penColorSemanticsLabel(d, color),
                            onTap: (color) {
                              onColorChanged(color);
                              onEraseModeChanged(false);
                            },
                          ),
                        )),
                    IconButton(
                      tooltip: volume == 0.0 ? d.drawSemanticUnmute : d.drawSemanticMute,
                      onPressed: () {
                        final double newVolume = volume == 0.0 ? 1.0 : 0.0;
                        onVolumeChanged(newVolume);
                      },
                      icon: Icon(
                        volume == 0.0 ? Icons.volume_off : Icons.volume_up,
                        color: AppColors.surfaceColor,
                        size: responsive
                            .tinyIconSize, // largeIconSize yerine mediumIconSize kullanıldı
                      ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
