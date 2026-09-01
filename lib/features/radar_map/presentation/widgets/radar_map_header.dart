import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/spidey_badge.dart';

class RadarMapHeader extends StatelessWidget {
  final int sightingsCount;

  const RadarMapHeader({
    super.key,
    required this.sightingsCount,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.p12,
          vertical: AppDimensions.p4,
        ),
        child: Row(
          children: [
            // Back Button
            Container(
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
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
              child: IconButton(
                padding: const EdgeInsets.all(AppDimensions.p8),
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.badgeCream,
                  size: 18,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(width: AppDimensions.p8),

            // Radar Title & Active Sightings Count (Flexible with no overflow)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.p8,
                  vertical: AppDimensions.p8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
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
                child: Row(
                  children: [
                    const Icon(
                      Icons.radar,
                      size: 16,
                      color: AppColors.primarySkyBlue,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'SPIDEY RADAR',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.headlineSmall(context).copyWith(
                          fontSize: 12,
                          color: AppColors.webWhite,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    SpideyBadge(
                      label: '$sightingsCount SIGHTINGS',
                      backgroundColor: AppColors.primarySkyBlue,
                      textColor: AppColors.pixelBlack,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
