import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/pixel_border_card.dart';
import '../cubit/tracker_cubit.dart';
import '../cubit/tracker_state.dart';

class WebFluidGauge extends StatelessWidget {
  const WebFluidGauge({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackerCubit, TrackerState>(
      builder: (context, state) {
        final percentage = state.webFluidPercentage;
        final isLow = percentage < 0.25;

        return PixelBorderCard(
          padding: const EdgeInsets.all(AppDimensions.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.water_drop,
                        size: 18,
                        color: AppColors.webFluidBlue,
                      ),
                      const SizedBox(width: AppDimensions.p4),
                      Text(
                        AppStrings.webFluidLevel,
                        style: AppTextStyles.headlineSmall(context).copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${(percentage * 100).toInt()}%',
                    style: AppTextStyles.telemetry(
                      isLow ? AppColors.spideyRed : AppColors.webFluidBlue,
                    ).copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.p12),

              // Fluid Level Segmented Bar
              Container(
                height: 14,
                width: double.infinity,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.pixelBlack,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                  border: Border.all(
                    color: AppColors.pixelBlack,
                    width: 1.5,
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        Container(
                          width: constraints.maxWidth,
                          color: AppColors.darkSurface,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: constraints.maxWidth * percentage,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isLow
                                  ? [AppColors.spideyRed, AppColors.spideyRedLight]
                                  : [AppColors.webFluidBlue, AppColors.primarySkyBlue],
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: AppDimensions.p12),

              // Quick Actions: Shoot Web / Reload Cartridge
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<TrackerCubit>().shootWeb();
                      },
                      icon: const Icon(Icons.flash_on, size: 16),
                      label: const Text('THWIP'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.spideyRed,
                        side: const BorderSide(
                          color: AppColors.pixelBlack,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: AppDimensions.p8),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.p8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<TrackerCubit>().reloadWebCartridge();
                      },
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text('RELOAD'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primarySkyBlueDark,
                        side: const BorderSide(
                          color: AppColors.pixelBlack,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: AppDimensions.p8),
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
