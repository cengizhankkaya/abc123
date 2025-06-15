import 'package:flutter/material.dart';

class BuildStrokeButton extends StatelessWidget {
  final double width;
  final double size;
  final double currentStrokeWidth;
  final bool eraseMode;
  final Function(double) onTap;

  const BuildStrokeButton({
    super.key,
    required this.width,
    required this.size,
    required this.currentStrokeWidth,
    required this.eraseMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentStrokeWidth == width && !eraseMode;
    return GestureDetector(
      onTap: () {
        onTap(width);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade400,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 1,
              ),
          ],
        ),
        child: Center(
          child: Container(
            width: width * 0.6,
            height: width * 0.6,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
