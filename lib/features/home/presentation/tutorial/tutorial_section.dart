import 'package:abc123/features/home/presentation/tutorial/tutorial_screen.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/image_manager.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/constants/language_constants.dart';

class TutorialSection extends StatelessWidget {
  final AppLanguage lang;
  final Size size;
  final String Function(String, AppLanguage) getLocalizedText;
  const TutorialSection({
    Key? key,
    required this.lang,
    required this.size,
    required this.getLocalizedText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => YoutubeVideoScreen(),
              ),
            );
          },
          child: Text(
            getLocalizedText('seeTutorial', lang),
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
            onTap: () {
              Navigator.pushNamed(context, '/tutorial');
            },
            child: Container(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        getLocalizedText('tutorial', lang),
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
