import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/cubit/theme_cubit.dart';
import '../../../../core/theme/cubit/theme_state.dart';

class TrackerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TrackerAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(68.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: AppDimensions.p16,
      title: Row(
        children: [
          // Spidey Pixel Icon Badge
          Container(
            width: AppDimensions.logoSizeSmall,
            height: AppDimensions.logoSizeSmall,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.badgeCream,
              border: Border.all(
                color: AppColors.pixelBlack,
                width: 2.0,
              ),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.pixelBlack,
                  offset: Offset(1.5, 1.5),
                  blurRadius: 0,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                AppAssets.spideyIcon,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.none,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.p12),
          // App Title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.appName.toUpperCase(),
                style: AppTextStyles.headlineSmall(context).copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'QUEENS HUD • SECTOR 4',
                style: AppTextStyles.telemetry(
                  Theme.of(context).brightness == Brightness.dark
                      ? AppColors.primarySkyBlue
                      : AppColors.textSecondaryLight,
                ).copyWith(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
      actions: [
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return Container(
              margin: const EdgeInsets.only(right: AppDimensions.p16),
              decoration: BoxDecoration(
                color: themeState.isDarkMode
                    ? AppColors.darkSurfaceElevated
                    : AppColors.lightSurface,
                borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                border: Border.all(
                  color: AppColors.pixelBlack,
                  width: 1.5,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.pixelBlack,
                    offset: Offset(1.5, 1.5),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  themeState.isDarkMode
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                  color: themeState.isDarkMode
                      ? AppColors.badgeCream
                      : AppColors.pixelBlack,
                  size: 20,
                ),
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                tooltip: 'Toggle Theme',
              ),
            );
          },
        ),
      ],
    );
  }
}
