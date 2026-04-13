import 'package:abc123/features/draw/presentation/widgets/admob_banner_widget.dart';
import 'package:abc123/features/home/l10n/home_string_lookup.dart';
import 'package:abc123/features/home/l10n/l10n_extensions.dart';
import 'package:abc123/features/home/presentation/gamification_icon_catalog.dart';
import 'package:abc123/features/home/presentation/providers/gamification_provider.dart';
import 'package:abc123/features/home/presentation/widgets/badge_filter_widget.dart';
import 'package:abc123/features/home/presentation/widgets/badge_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BadgesScreen extends StatefulWidget {
  final bool isTab;
  const BadgesScreen({super.key, this.isTab = false});

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  BadgeFilter _selectedFilter = BadgeFilter.all;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GamificationProvider>();
    final h = context.homeL10n!;

    // Filter logic
    final allBadges = provider.badges;
    final filteredBadges = allBadges.where((badge) {
      if (_selectedFilter == BadgeFilter.earned) {
        return !badge.isLocked;
      } else if (_selectedFilter == BadgeFilter.locked) {
        return badge.isLocked;
      }
      return true; // BadgeFilter.all
    }).toList();

    // Stats
    final unlockedCount = allBadges.where((b) => !b.isLocked).length;
    final totalCount = allBadges.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8), // Soft gray-blue background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFDCE9F5), // Lighter blue maching image top
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom Back Button if not tab
              if (!widget.isTab)
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: IconButton(
                      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),

              const SizedBox(height: 10),

              // Custom Header (Ribbon + ProgressBar)
              BadgeHeaderWidget(
                unlockedCount: unlockedCount,
                totalCount: totalCount,
              ),

              // Filter Tabs
              BadgeFilterWidget(
                selectedFilter: _selectedFilter,
                onFilterChanged: (filter) {
                  setState(() {
                    _selectedFilter = filter;
                  });
                },
              ),

              const SizedBox(height: 10),
              const AdmobBannerWidget(),
              const SizedBox(height: 10),

              // Badges Grid
              Expanded(
                child: filteredBadges.isEmpty
                    ? Center(
                        child: Text(
                          h.noBadgesFound,
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 24,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: filteredBadges.length,
                        itemBuilder: (context, index) {
                          final badge = filteredBadges[index];
                          return GestureDetector(
                            key: ValueKey<String>('badge-grid-${badge.id}'),
                            onTap: () {
                              showDialog<void>(
                                context: context,
                                builder: (context) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          badge.isLocked
                                              ? Icons.lock
                                              : gamificationIcon(badge.iconKey),
                                          size: 64,
                                          color: badge.isLocked
                                              ? Colors.grey
                                              : const Color(0xFF00B894),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          homeBadgeLine(h, badge.nameKey),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2D3436),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          homeBadgeLine(h, badge.descriptionKey),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF636E72),
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        ElevatedButton(
                                          onPressed: () => context.pop(),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF00B894),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 32,
                                              vertical: 12,
                                            ),
                                          ),
                                          child: Text(
                                            MaterialLocalizations.of(context).closeButtonLabel,
                                            style: const TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Badge Icon Container
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: badge.isLocked
                                        ? LinearGradient(
                                            colors: [Colors.grey.shade200, Colors.grey.shade300],
                                          )
                                        : const LinearGradient(
                                            colors: [Color(0xFF00B894), Color(0xFF55EFC4)],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                    shape: BoxShape.circle,
                                    boxShadow: badge.isLocked
                                        ? []
                                        : [
                                            BoxShadow(
                                              color: const Color(0xFF00B894).withOpacity(0.4),
                                              blurRadius: 12,
                                              offset: const Offset(0, 6),
                                            ),
                                          ],
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 4,
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      badge.isLocked ? Icons.lock : gamificationIcon(badge.iconKey),
                                      size: 36,
                                      color: badge.isLocked ? Colors.grey.shade500 : Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Badge Name
                                Text(
                                  homeBadgeLine(h, badge.nameKey),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: badge.isLocked ? Colors.grey : const Color(0xFF2D3436),
                                    height: 1.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
