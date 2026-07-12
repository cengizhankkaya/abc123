import 'package:abc123/core/navigation/route_paths.dart';
import 'package:abc123/features/home/presentation/performance/gamification_layout_signatures.dart';
import 'package:abc123/features/home/presentation/gamification_icon_catalog.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeBadgesWidget extends StatelessWidget {
  const HomeBadgesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<GamificationProvider, int>(
      selector: (_, p) => unlockedBadgeListSignature(p.unlockedBadges),
      builder: (context, _, __) {
        final provider = context.read<GamificationProvider>();
        final unlockedBadges = provider.unlockedBadges;
        final h = context.homeL10n!;

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
                  h.badgesTitle,
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
                      key: ValueKey<String>('home-badge-${badge.id}'),
                      onTap: () => context.push(AppRoutes.badgesFull),
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
                          gamificationIcon(badge.iconKey),
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
