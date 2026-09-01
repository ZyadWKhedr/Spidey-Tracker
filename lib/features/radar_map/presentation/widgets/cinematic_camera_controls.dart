import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/radar_map_cubit.dart';
import '../cubit/radar_map_state.dart';

class CinematicCameraControls extends StatelessWidget {
  const CinematicCameraControls({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadarMapCubit, RadarMapState>(
      builder: (context, state) {
        final cubit = context.read<RadarMapCubit>();

        return Container(
          padding: const EdgeInsets.all(AppDimensions.p4),
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
                offset: Offset(2, 3),
                blurRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _CameraLevelButton(
                label: 'STREET',
                icon: Icons.streetview,
                isSelected: state.cameraLevel == CameraLevel.street,
                onTap: () => cubit.animateToLevel(CameraLevel.street),
              ),
              const SizedBox(height: 2),
              _CameraLevelButton(
                label: 'DISTRICT',
                icon: Icons.location_city,
                isSelected: state.cameraLevel == CameraLevel.district,
                onTap: () => cubit.animateToLevel(CameraLevel.district),
              ),
              const SizedBox(height: 2),
              _CameraLevelButton(
                label: 'COUNTRY',
                icon: Icons.map,
                isSelected: state.cameraLevel == CameraLevel.country,
                onTap: () => cubit.animateToLevel(CameraLevel.country),
              ),
              const SizedBox(height: 2),
              _CameraLevelButton(
                label: 'WORLD',
                icon: Icons.public,
                isSelected: state.cameraLevel == CameraLevel.world,
                onTap: () => cubit.animateToLevel(CameraLevel.world),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CameraLevelButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _CameraLevelButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primarySkyBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 14,
              color: isSelected ? AppColors.pixelBlack : AppColors.badgeCream,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.telemetry(
                isSelected ? AppColors.pixelBlack : AppColors.textSecondaryDark,
              ).copyWith(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
