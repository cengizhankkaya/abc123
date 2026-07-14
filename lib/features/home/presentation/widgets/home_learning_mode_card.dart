import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:flutter/material.dart';

class HomeLearningModeCard extends StatefulWidget {
  const HomeLearningModeCard({
    required this.title,
    required this.subtitle,
    required this.baseColor,
    required this.image,
    required this.onTap,
    this.useDarkText = false,
    super.key,
  });

  final String title;
  final String subtitle;
  final Color baseColor;
  final Widget image;
  final VoidCallback onTap;
  final bool useDarkText;

  @override
  State<HomeLearningModeCard> createState() => _HomeLearningModeCardState();
}

class _HomeLearningModeCardState extends State<HomeLearningModeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.useDarkText ? HomeDesignTokens.darkText : Colors.white;
    final subtitleColor =
        widget.useDarkText ? HomeDesignTokens.mutedText : Colors.white.withValues(alpha: 0.92);

    return Semantics(
      button: true,
      label: '${widget.title}. ${widget.subtitle}',
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap();
        },
        onTapCancel: () => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: widget.baseColor,
              borderRadius: BorderRadius.circular(HomeDesignTokens.cardRadius),
              boxShadow: [
                BoxShadow(
                  color: widget.baseColor.withValues(alpha: 0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(HomeDesignTokens.cardRadius),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ExcludeSemantics(child: widget.image),
                  ),
                  ColoredBox(
                    color: widget.baseColor,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.title,
                            style: HomeDesignTokens.cardTitle(color: textColor),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.subtitle,
                            style: HomeDesignTokens.cardSubtitle(color: subtitleColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
