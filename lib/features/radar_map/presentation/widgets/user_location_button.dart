import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../cubit/radar_map_cubit.dart';
import '../cubit/radar_map_state.dart';

class UserLocationButton extends StatelessWidget {
  const UserLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadarMapCubit, RadarMapState>(
      builder: (context, state) {
        final isLoading = state.isLoadingLocation;

        return Container(
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
          child: IconButton(
            icon: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(
                        AppColors.primarySkyBlue,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.my_location,
                    color: AppColors.primarySkyBlue,
                    size: 22,
                  ),
            onPressed: isLoading
                ? null
                : () => context.read<RadarMapCubit>().requestUserLocation(),
            tooltip: 'Acquire User GPS Location',
          ),
        );
      },
    );
  }
}
