import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final VoidCallback onTap;
  final Widget image;
  final Widget? overlay;
  final double width;
  final double height;

  const ActivityCard({
    required this.onTap,
    required this.image,
    this.overlay,
    this.width = 160,
    this.height = 160,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
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
