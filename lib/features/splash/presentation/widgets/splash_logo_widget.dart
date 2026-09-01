import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

class SplashLogoWidget extends StatelessWidget {
  const SplashLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Spidey Pixel Badge
        Container(
          width: AppDimensions.logoSizeLarge,
          height: AppDimensions.logoSizeLarge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.badgeCream,
            border: Border.all(
              color: AppColors.pixelBlack,
              width: 3.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.pixelBlack.withValues(alpha: 0.25),
                offset: const Offset(4, 6),
                blurRadius: 0,
              ),
              BoxShadow(
                color: AppColors.primarySkyBlue.withValues(alpha: 0.4),
                offset: const Offset(-2, -2),
                blurRadius: 16,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              AppAssets.spideyIcon,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.none, // Preserve crisp pixel-art look
            ),
          ),
        ),
      ],
    );
  }
}
