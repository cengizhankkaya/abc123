import 'package:abc123/core/constants/app_font_sizes.dart';
import 'package:abc123/core/constants/app_radii.dart';
import 'package:abc123/core/constants/app_sizes.dart';
import 'package:abc123/core/infrastructure/images/image_manager.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.paddingNormal(context)),
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6C5CE7).withOpacity(0.1),
            const Color(0xFFA29BFE).withOpacity(0.1)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.8),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.imageRadius(context)),
            child: Container(
              width: AppSizes.imageSize(context),
              height: AppSizes.imageSize(context),
              color: Colors.grey.withOpacity(0.3),
              child: ExcludeSemantics(
                child: ImageManager.getRobotImage(
                  width: AppSizes.imageSize(context),
                  height: AppSizes.imageSize(context),
                ),
              ),
            ),
          ),
          SizedBox(width: AppSizes.paddingNormal(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  h.hello,
                  style: TextStyle(
                    fontSize: AppFontSizes.title(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: AppSizes.paddingSmall(context)),
                Text(
                  h.slogan,
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
