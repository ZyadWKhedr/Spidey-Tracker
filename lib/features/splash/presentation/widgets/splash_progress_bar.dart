import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

class SplashProgressBar extends StatelessWidget {
  final double progress;

  const SplashProgressBar({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);

    return Container(
      width: 240,
      height: 18,
      padding: const EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        color: AppColors.pixelBlack,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        border: Border.all(
          color: AppColors.pixelBlack,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.pixelBlack,
            offset: Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final barWidth = constraints.maxWidth * clampedProgress;
          return Stack(
            children: [
              // Background track
              Container(
                width: constraints.maxWidth,
                color: AppColors.darkSurface,
              ),
              // Animated progress fill
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutQuad,
                width: barWidth,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.spideyRed,
                      AppColors.badgeCreamDark,
                      AppColors.primarySkyBlue,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
