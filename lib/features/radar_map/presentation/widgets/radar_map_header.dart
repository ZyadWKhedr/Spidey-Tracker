import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/spidey_badge.dart';
import '../cubit/radar_map_cubit.dart';
import '../cubit/radar_map_state.dart';

class RadarMapHeader extends StatelessWidget {
  const RadarMapHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadarMapCubit, RadarMapState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.p16,
              vertical: AppDimensions.p8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.badgeCream,
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),

                // Radar Title & Active Sightings Count
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.p16,
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.radar,
                        size: 18,
                        color: AppColors.primarySkyBlue,
                      ),
                      const SizedBox(width: AppDimensions.p8),
                      Text(
                        'GLOBAL SPIDER-RADAR',
                        style: AppTextStyles.headlineSmall(context).copyWith(
                          fontSize: 13,
                          color: AppColors.webWhite,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.p8),
                      SpideyBadge(
                        label: '${state.sightings.length} SIGHTINGS',
                        backgroundColor: AppColors.primarySkyBlue,
                        textColor: AppColors.pixelBlack,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
