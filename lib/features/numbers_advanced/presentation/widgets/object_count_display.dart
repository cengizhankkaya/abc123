import 'dart:async';
import 'package:flutter/material.dart';

class ObjectCountDisplay extends StatefulWidget {
  const ObjectCountDisplay({
    required this.count,
    required this.emoji,
    this.isCountingMode = false,
    this.startIndex = 0,
    super.key,
  });

  final int count;
  final String emoji;
  final bool isCountingMode;
  final int startIndex;

  @override
  State<ObjectCountDisplay> createState() => _ObjectCountDisplayState();
}

class _ObjectCountDisplayState extends State<ObjectCountDisplay> {
  int _activeHighlightIndex = -1;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.isCountingMode) {
      _startCountingAnimation();
    }
  }

  @override
  void didUpdateWidget(covariant ObjectCountDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCountingMode && !oldWidget.isCountingMode) {
      _startCountingAnimation();
    } else if (!widget.isCountingMode) {
      _timer?.cancel();
      setState(() {
        _activeHighlightIndex = -1;
      });
    }
  }

  void _startCountingAnimation() {
    _timer?.cancel();
    _activeHighlightIndex = -1;
    // Delay slightly based on startIndex so operandB waits for operandA to finish
    final initialDelay = widget.startIndex * 700;
    
    Future.delayed(Duration(milliseconds: initialDelay), () {
      if (!mounted || !widget.isCountingMode) return;
      
      setState(() {
        _activeHighlightIndex = 0;
      });

      _timer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
        if (!mounted || !widget.isCountingMode) {
          timer.cancel();
          return;
        }
        if (_activeHighlightIndex < widget.count - 1) {
          setState(() {
            _activeHighlightIndex++;
          });
        } else {
          // Finished counting this group
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 1000), () {
            if (mounted && widget.isCountingMode) {
              setState(() {
                _activeHighlightIndex = -1;
              });
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double emojiSize = widget.count > 6 ? 24 : (widget.count > 4 ? 30 : 36);
    final double spacing = widget.count > 6 ? 6 : (widget.count > 4 ? 8 : 10);

    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.isCountingMode ? const Color(0xFFFFF2CC) : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: widget.isCountingMode ? const Color(0xFFF1C40F) : Colors.white,
          width: widget.isCountingMode ? 3 : 2,
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: spacing,
            runSpacing: spacing,
            children: List.generate(widget.count, (index) {
              final isHighlighted = index == _activeHighlightIndex;
              final currentNumber = widget.startIndex + index + 1;

              return AnimatedScale(
                scale: isHighlighted ? 1.3 : 1.0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutBack,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isHighlighted ? const Color(0xFFF1C40F).withOpacity(0.3) : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Text(
                        widget.emoji,
                        style: TextStyle(fontSize: emojiSize),
                      ),
                      if (widget.isCountingMode && (_activeHighlightIndex >= index || _activeHighlightIndex == -1))
                        Positioned(
                          top: -6,
                          right: -6,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: (_activeHighlightIndex >= index) ? 1.0 : 0.4,
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                color: Color(0xFF6C63FF),
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                              child: Center(
                                child: Text(
                                  '$currentNumber',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
