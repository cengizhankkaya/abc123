import 'package:flutter/material.dart';

class BuildColorButton extends StatelessWidget {

  const BuildColorButton({
    required this.color, required this.size, required this.selectedColor, required this.eraseMode, required this.onTap, required this.semanticsLabel, super.key,
  });
  final Color color;
  final double size;
  final Color selectedColor;
  final bool eraseMode;
  final void Function(Color) onTap;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedColor == color && !eraseMode;
    return Semantics(
      button: true,
      label: semanticsLabel,
      selected: isSelected,
      child: GestureDetector(
        onTap: () {
          onTap(color);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: color.withValues(alpha: 0.6),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: isSelected
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: size * 0.6,
                )
              : null,
        ),
      ),
    );
  }
}
