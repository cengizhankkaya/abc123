import 'package:flutter/material.dart';

class BuildColorButton extends StatelessWidget {
  final Color color;
  final double size;
  final Color selectedColor;
  final bool eraseMode;
  final void Function(Color) onTap;
  final String semanticsLabel;

  const BuildColorButton({
    super.key,
    required this.color,
    required this.size,
    required this.selectedColor,
    required this.eraseMode,
    required this.onTap,
    required this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedColor == color && !eraseMode;
    return Semantics(
      button: true,
      label: semanticsLabel,
      selected: isSelected,
      child: GestureDetector(
        onTap: () {
          onTap(color);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: color.withOpacity(0.6),
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
