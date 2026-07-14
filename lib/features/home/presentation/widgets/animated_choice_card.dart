import 'package:abc123/features/home/presentation/theme/home_design_tokens.dart';
import 'package:flutter/material.dart';

/// Tema, dil vb. seçenekler için minimum 48x48 dokunma alanına sahip,
/// mikro ölçek ve renk geçiş animasyonlu seçim kartı.
class AnimatedChoiceCard extends StatefulWidget {
  const AnimatedChoiceCard({
    required this.title, required this.isSelected, required this.onTap, super.key,
    this.subtitle,
    this.leading,
    this.activeBgColor,
    this.activeBorderColor,
    this.minHeight = 52.0,
    this.minWidth = 48.0,
    this.showCheckmark = true,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? activeBgColor;
  final Color? activeBorderColor;
  final double minHeight;
  final double minWidth;
  final bool showCheckmark;

  @override
  State<AnimatedChoiceCard> createState() => _AnimatedChoiceCardState();
}

class _AnimatedChoiceCardState extends State<AnimatedChoiceCard> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails _) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails _) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final activeBg = widget.activeBgColor ?? HomeDesignTokens.settingsChoiceActiveBg;
    final activeBorder = widget.activeBorderColor ?? HomeDesignTokens.settingsChoiceActiveBorder;

    return Semantics(
      button: true,
      selected: widget.isSelected,
      label: '${widget.title}${widget.subtitle != null ? ', ${widget.subtitle}' : ''}',
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isPressed ? 0.95 : 1.0,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            constraints: BoxConstraints(
              minWidth: widget.minWidth,
              minHeight: widget.minHeight,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: widget.isSelected ? activeBg : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.isSelected
                    ? activeBorder
                    : HomeDesignTokens.settingsChoiceInactiveBorder,
                width: widget.isSelected ? 2.0 : 1.5,
              ),
              boxShadow: [
                if (widget.isSelected)
                  BoxShadow(
                    color: activeBorder.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                else
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.leading != null) ...[
                  widget.leading!,
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        style: HomeDesignTokens.cardTitle(
                          color: HomeDesignTokens.darkText,
                        ).copyWith(
                          fontSize: 15,
                          fontWeight: widget.isSelected
                              ? FontWeight.w800
                              : FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          widget.subtitle!,
                          style: HomeDesignTokens.cardSubtitle(
                            color: HomeDesignTokens.mutedText,
                          ).copyWith(fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                if (widget.showCheckmark && widget.isSelected) ...[
                  const SizedBox(width: 8),
                  Icon(
                    Icons.check_circle_rounded,
                    color: activeBorder,
                    size: 20,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
