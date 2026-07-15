import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    required this.onTap,
    required this.image,
    this.overlay,
    this.width = 160,
    this.height = 160,
    super.key,
  });
  final VoidCallback onTap;
  final Widget image;
  final Widget? overlay;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: width,
                height: height,
                child: image,
              ),
            ),
            if (overlay != null) overlay!,
          ],
        ),
      ),
    );
  }
}
