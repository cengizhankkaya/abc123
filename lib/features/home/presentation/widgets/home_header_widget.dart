import 'package:abc123/core/presentation/performance/gamification_layout_signatures.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GamificationProvider, int>(
      selector: (_, p) => headerPointsStreakSignature(p),
      builder: (context, _, __) {
        final provider = context.read<GamificationProvider>();
        final h = context.homeL10n!;
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
                        h.hello,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        h.slogan,
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
                  _HeaderStatItem(
                    icon: Icons.star_rounded,
                    value: provider.points.toString(),
                    label: h.points,
                    iconColor: Colors.amberAccent,
                  ),
                  Container(width: 1, height: 40, color: Colors.white24),
                  _HeaderStatItem(
                    icon: Icons.local_fire_department_rounded,
                    value: provider.streak.toString(),
                    label: h.streakDay,
                    iconColor: Colors.orangeAccent,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HeaderStatItem extends StatelessWidget {
  const _HeaderStatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
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
