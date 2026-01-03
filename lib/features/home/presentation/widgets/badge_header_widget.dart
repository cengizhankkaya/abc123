import 'package:abc123/core/constants/app_sizes.dart';
import 'package:abc123/core/utils/responsive_size.dart';
import 'package:flutter/material.dart';

class BadgeHeaderWidget extends StatelessWidget {
  final int unlockedCount;
  final int totalCount;

  const BadgeHeaderWidget({
    super.key,
    required this.unlockedCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSize(context);

    // Progress percentage
    final double progress = totalCount > 0 ? unlockedCount / totalCount : 0.0;

    return Column(
      children: [
        // Ribbon Header
        SizedBox(
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Ribbon Background (Back parts)
              // Left Ear
              Positioned(
                left: 20,
                top: 10,
                child: Transform(
                  transform: Matrix4.skewY(-0.3),
                  child: Container(
                    width: 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF90B4CE), // Darker blue
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
                ),
              ),
              // Right Ear
              Positioned(
                right: 20,
                top: 10,
                child: Transform(
                  transform: Matrix4.skewY(0.3),
                  child: Container(
                    width: 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF90B4CE), // Darker blue
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
                ),
              ),
              // Main Banner
              Container(
                width: 280,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xFFA9D1EA), // Light blue
                    border: Border.all(color: Colors.black, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      )
                    ]),
                child: const Text(
                  'ROZETLERİM',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Progress Info
        Text(
          'Toplam: $unlockedCount/$totalCount',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 5),

        // Progress Bar with Icon
        SizedBox(
          height: 60,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Bar Container
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 10),
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    //  border: Border.all(color: Colors.black54, width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.transparent,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFFFA502)), // Orange
                      minHeight: 24,
                    ),
                  ),
                ),
              ),
              // Badge Icon
              Positioned(
                left: 0,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFD32A),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        )
                      ]),
                  child: const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFA502),
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
