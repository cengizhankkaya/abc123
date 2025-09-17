import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/image_manager.dart';
import '../../../../core/constants/language_constants.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_radii.dart';
import '../../../../core/constants/app_font_sizes.dart';

class WelcomeCard extends StatelessWidget {
  final AppLanguage lang;
  const WelcomeCard({required this.lang, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.paddingNormal(context)),
      decoration: BoxDecoration(
        color: AppColors.panelColor,
        borderRadius: BorderRadius.circular(AppRadii.cardRadius(context)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.imageRadius(context)),
            child: Container(
              width: AppSizes.imageSize(context),
              height: AppSizes.imageSize(context),
              color: Colors.grey.withOpacity(0.3),
              child: ImageManager.getRobotImage(
                width: AppSizes.imageSize(context),
                height: AppSizes.imageSize(context),
              ),
            ),
          ),
          SizedBox(width: AppSizes.paddingNormal(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getLocalizedText('hello', lang),
                  style: TextStyle(
                    fontSize: AppFontSizes.title(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: AppSizes.paddingSmall(context)),
                Text(
                  getLocalizedText('slogan', lang),
                  style: TextStyle(
                    fontSize: AppFontSizes.subtitle(context),
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
