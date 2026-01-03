import 'package:abc123/core/constants/language_constants.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/screens/badges_screen.dart';
import 'package:abc123/shared/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBadgesWidget extends StatelessWidget {
  const HomeBadgesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GamificationProvider>(
      builder: (context, provider, _) {
        final unlockedBadges = provider.unlockedBadges;
        final lang = context.watch<LanguageProvider>().language;

        if (unlockedBadges.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          height: 90,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                child: Text(
                  getLocalizedText('badgesTitle', lang),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: unlockedBadges.length,
                  itemBuilder: (context, index) {
                    final badge = unlockedBadges[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BadgesScreen()),
                        );
                      },
                      child: Container(
                        width: 60,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6C5CE7).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          badge.iconData,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
