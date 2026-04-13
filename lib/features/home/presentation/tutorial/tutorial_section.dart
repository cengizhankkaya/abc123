import 'package:abc123/core/constants/app_colors.dart';
import 'package:abc123/core/infrastructure/images/image_manager.dart';
import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/core/constants/image_constants.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TutorialSection extends StatelessWidget {
  final Size size;
  const TutorialSection({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final h = context.homeL10n!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => context.push(AppRoutes.tutorial),
          child: Text(
            h.seeTutorial,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.02),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => context.push(AppRoutes.tutorial),
            child: SizedBox(
              height: size.height * 0.2,
              width: double.infinity,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: size.height * 0.2,
                      width: double.infinity,
                      color: AppColors.backgroundColor,
                      child: ImageManager.getImage(
                        ImageConstants.tutorialImage,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        h.tutorial,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
