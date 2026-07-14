import 'package:flutter/material.dart';

class WordLetterSlots extends StatelessWidget {
  const WordLetterSlots({
    required this.spelling, required this.activeIndex, super.key,
    this.alignment = WrapAlignment.center,
    this.maxWidth,
  });

  final String spelling;
  final int activeIndex;
  final WrapAlignment alignment;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final letters = spelling.split('');
    final width = maxWidth ?? MediaQuery.sizeOf(context).width;
    final slotSize = _slotSizeFor(letters.length, width);
    const spacing = 6.0;

    return Row(
      mainAxisAlignment: _mainAxisAlignment(alignment),
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < letters.length; i++) ...[
          if (i > 0) const SizedBox(width: spacing),
          _Slot(
            letter: i < activeIndex ? letters[i] : '',
            isActive: i == activeIndex,
            isCompleted: i < activeIndex,
            size: slotSize,
          ),
        ],
      ],
    );
  }

  MainAxisAlignment _mainAxisAlignment(WrapAlignment alignment) {
    return switch (alignment) {
      WrapAlignment.start => MainAxisAlignment.start,
      WrapAlignment.end => MainAxisAlignment.end,
      WrapAlignment.center => MainAxisAlignment.center,
      _ => MainAxisAlignment.center,
    };
  }

  double _slotSizeFor(int letterCount, double availableWidth) {
    if (letterCount == 0) return 0;
    if (availableWidth <= 0 || !availableWidth.isFinite) {
      return letterCount <= 3 ? 32 : 26;
    }
    const spacing = 6.0;
    final fit = (availableWidth - (letterCount - 1) * spacing) / letterCount;
    return fit.clamp(14.0, 44.0);
  }
}

class _Slot extends StatelessWidget {
  const _Slot({
    required this.letter,
    required this.isActive,
    required this.isCompleted,
    required this.size,
  });

  final String letter;
  final bool isActive;
  final bool isCompleted;
  final double size;

  @override
  Widget build(BuildContext context) {
    const base = Colors.white;
    final border = isActive
        ? const Color(0xFF00B894)
        : isCompleted
            ? const Color(0xFF74B9FF)
            : Colors.black26;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: base,
        borderRadius: BorderRadius.circular(size * 0.26),
        border: Border.all(color: border, width: isActive ? 2.5 : 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: TextStyle(
          fontSize: size * 0.44,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
