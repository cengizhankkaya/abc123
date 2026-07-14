import 'package:abc123/features/words/presentation/widgets/word_letter_slots.dart';
import 'package:flutter/material.dart';

/// Hedef kelime gösterimi (emoji + yerelleştirilmiş ad + harf slotları).
class WordTargetDisplay extends StatelessWidget {
  const WordTargetDisplay({
    required this.emoji, required this.displayText, required this.spelling, required this.activeLetterIndex, super.key,
    this.compact = false,
    this.showSlots = true,
    this.slotsAlignment = WrapAlignment.center,
  });

  final String emoji;
  final String displayText;
  final String spelling;
  final int activeLetterIndex;
  final bool compact;
  final bool showSlots;
  final WrapAlignment slotsAlignment;

  @override
  Widget build(BuildContext context) {
    final emojiSize = compact ? 28.0 : 40.0;
    final titleSize = compact ? 15.0 : 20.0;
    final spellingSize = compact ? 10.0 : 12.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: TextStyle(fontSize: emojiSize)),
        SizedBox(height: compact ? 4 : 8),
        Text(
          displayText,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF00B894),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          spelling,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: spellingSize,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: Colors.grey.shade700,
          ),
        ),
        if (showSlots) ...[
          SizedBox(height: compact ? 6 : 10),
          LayoutBuilder(
            builder: (context, constraints) {
              return WordLetterSlots(
                spelling: spelling,
                activeIndex: activeLetterIndex,
                alignment: slotsAlignment,
                maxWidth: constraints.maxWidth.isFinite ? constraints.maxWidth : 120,
              );
            },
          ),
        ],
      ],
    );
  }
}
