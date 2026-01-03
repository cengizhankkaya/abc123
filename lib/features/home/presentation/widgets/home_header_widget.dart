import 'package:abc123/core/constants/language_constants.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/shared/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GamificationProvider>(
      builder: (context, provider, _) {
        final lang = context.watch<LanguageProvider>().language;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C5CE7).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getLocalizedText('hello', lang),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        getLocalizedText('slogan', lang),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    Icons.star_rounded,
                    provider.points.toString(),
                    getLocalizedText('points', lang),
                    Colors.amberAccent,
                  ),
                  Container(width: 1, height: 40, color: Colors.white24),
                  _buildStatItem(
                    Icons.local_fire_department_rounded,
                    provider.streak.toString(),
                    getLocalizedText('streakDay', lang),
                    Colors.orangeAccent,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(
      IconData icon, String value, String label, Color iconColor) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
