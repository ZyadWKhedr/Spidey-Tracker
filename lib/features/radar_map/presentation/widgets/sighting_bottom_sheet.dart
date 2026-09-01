import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/pixel_border_card.dart';
import '../../../../core/widgets/spidey_badge.dart';
import '../../domain/entities/spidey_sighting.dart';
import '../cubit/radar_map_cubit.dart';
import '../cubit/radar_map_state.dart';

class SightingBottomSheet extends StatelessWidget {
  const SightingBottomSheet({super.key});

  Color _getTypeColor(SightingType type) {
    switch (type) {
      case SightingType.villainBattle:
        return AppColors.spideyRed;
      case SightingType.policeAssistance:
        return AppColors.alertOrange;
      case SightingType.catRescue:
        return AppColors.badgeCreamDark;
      case SightingType.photoOp:
        return AppColors.cyberPurple;
      case SightingType.webSlinging:
        return AppColors.primarySkyBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadarMapCubit, RadarMapState>(
      builder: (context, state) {
        final sighting = state.selectedSighting;
        if (sighting == null) return const SizedBox.shrink();

        final typeColor = _getTypeColor(sighting.type);

        return Positioned(
          left: AppDimensions.p16,
          right: AppDimensions.p16,
          bottom: AppDimensions.p24,
          child: PixelBorderCard(
            backgroundColor: AppColors.darkSurface,
            borderColor: typeColor,
            borderWidth: 2.5,
            padding: const EdgeInsets.all(AppDimensions.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SpideyBadge(
                          label: sighting.type.name.toUpperCase(),
                          backgroundColor: typeColor,
                          textColor: sighting.type == SightingType.villainBattle
                              ? Colors.white
                              : AppColors.pixelBlack,
                        ),
                        const SizedBox(width: AppDimensions.p8),
                        Text(
                          sighting.id,
                          style: AppTextStyles.telemetry(
                            AppColors.primarySkyBlueLight,
                          ).copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.textSecondaryDark,
                        size: 20,
                      ),
                      onPressed: () =>
                          context.read<RadarMapCubit>().clearSelectedSighting(),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.p8),

                // Title & District
                Text(
                  sighting.title,
                  style: AppTextStyles.headlineSmall(context).copyWith(
                    fontSize: 16,
                    color: AppColors.webWhite,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppDimensions.p4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: AppColors.spideyRed,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      sighting.district,
                      style: AppTextStyles.bodySmall(context).copyWith(
                        color: AppColors.textSecondaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      sighting.timestamp,
                      style: AppTextStyles.telemetry(
                        AppColors.badgeCream,
                      ).copyWith(fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.p8),

                // Report Notes
                Text(
                  sighting.reportNotes,
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    color: AppColors.textPrimaryDark,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: AppDimensions.p12),

                // Footer with Witness Count
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${sighting.witnessCount} WITNESSES CONFIRMED',
                      style: AppTextStyles.telemetry(
                        AppColors.patrolGreen,
                      ).copyWith(fontSize: 10),
                    ),
                    SpideyBadge(
                      label: 'SPIDEY VERIFIED ✓',
                      backgroundColor: AppColors.patrolGreen,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
