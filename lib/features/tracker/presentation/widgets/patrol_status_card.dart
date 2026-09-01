import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/pixel_border_card.dart';
import '../../../../core/widgets/spidey_badge.dart';
import '../cubit/tracker_cubit.dart';
import '../cubit/tracker_state.dart';

class PatrolStatusCard extends StatelessWidget {
  const PatrolStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackerCubit, TrackerState>(
      builder: (context, state) {
        final isPatrolActive = state.isPatrolActive;

        return PixelBorderCard(
          padding: const EdgeInsets.all(AppDimensions.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isPatrolActive
                              ? AppColors.patrolGreen
                              : AppColors.spideyRed,
                          boxShadow: [
                            BoxShadow(
                              color: (isPatrolActive
                                      ? AppColors.patrolGreen
                                      : AppColors.spideyRed)
                                  .withValues(alpha: 0.6),
                              blurRadius: 6,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppDimensions.p8),
                      Text(
                        isPatrolActive
                            ? AppStrings.patrolActive
                            : AppStrings.patrolStandby,
                        style: AppTextStyles.telemetry(
                          isPatrolActive
                              ? AppColors.patrolGreen
                              : AppColors.spideyRed,
                        ).copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SpideyBadge(
                    label: '${state.activeAlertsCount} ALERTS',
                    backgroundColor: state.activeAlertsCount > 0
                        ? AppColors.spideyRedLight
                        : AppColors.patrolGreen,
                    textColor: AppColors.pixelBlack,
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.p16),

              // Metrics Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.citySafetyRating,
                        style: AppTextStyles.bodySmall(context).copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.p4),
                      Text(
                        '${state.citySafetyIndex.toStringAsFixed(1)}%',
                        style: AppTextStyles.headlineMedium(context).copyWith(
                          color: AppColors.patrolGreen,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),

                  // Patrol Toggle Button
                  ElevatedButton(
                    onPressed: () {
                      context.read<TrackerCubit>().togglePatrol();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPatrolActive
                          ? AppColors.badgeCream
                          : AppColors.primarySkyBlue,
                      foregroundColor: AppColors.pixelBlack,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusSm),
                        side: const BorderSide(
                          color: AppColors.pixelBlack,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.p16,
                        vertical: AppDimensions.p12,
                      ),
                    ),
                    child: Text(
                      isPatrolActive ? 'STANDBY' : 'ENGAGE',
                      style: AppTextStyles.headlineSmall(context).copyWith(
                        fontSize: 13,
                        color: AppColors.pixelBlack,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
