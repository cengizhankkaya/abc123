// ignore_for_file: deprecated_member_use

import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/utils/responsive_size.dart';
import 'package:flutter/material.dart';

import '../../../draw/data/models/drawing_content.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_radii.dart';

class LetterGuideCard extends StatefulWidget {
  final DrawingGuide guide;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const LetterGuideCard({
    super.key,
    required this.guide,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  State<LetterGuideCard> createState() => _LetterGuideCardState();
}

class _LetterGuideCardState extends State<LetterGuideCard> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);

    return Container(
      margin: EdgeInsets.only(
        left: AppSizes.paddingNormal(context),
        top: AppSizes.paddingSmall(context),
        bottom: AppSizes.paddingSmall(context),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(AppRadii.cardRadius(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: AppSizes.paddingLarge(context) * 0.5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Harf resmi (arka planda tam ekran)
            Positioned.fill(
              child: Image.asset(
                widget.guide.imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            // Sol üst köşe - Geri butonu
            Positioned(
              left: 8,
              top: 8,
              child: GestureDetector(
                onTap: widget.onPrevious,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: responsive.smallIconSize * 0.8,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            // Sağ üst köşe - İleri butonu
            Positioned(
              right: 8,
              top: 8,
              child: GestureDetector(
                onTap: widget.onNext,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: responsive.smallIconSize * 0.8,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
