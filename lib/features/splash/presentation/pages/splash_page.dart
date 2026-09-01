import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/splash_cubit.dart';
import '../cubit/splash_state.dart';
import '../widgets/splash_logo_widget.dart';
import '../widgets/splash_progress_bar.dart';
import '../widgets/splash_status_text.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..startInitialization(),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  void _onStateChange(BuildContext context, SplashState state) {
    if (state is SplashCompleted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.tracker);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarySkyBlue,
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: _onStateChange,
        builder: (context, state) {
          final progress = state is SplashLoading ? state.progress : 0.0;
          final status = state is SplashLoading
              ? state.statusMessage
              : AppStrings.splashCalibrating;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.p24,
                vertical: AppDimensions.p32,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // App Title Header
                  Column(
                    children: [
                      Text(
                        AppStrings.appName.toUpperCase(),
                        style: AppTextStyles.headlineLarge(context).copyWith(
                          color: AppColors.pixelBlack,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.p4),
                      Text(
                        AppStrings.appTagline,
                        style: AppTextStyles.pixelBadge.copyWith(
                          fontSize: 16,
                          color: AppColors.pixelBlack.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),

                  // Center Pixel Spidey Logo
                  const SplashLogoWidget(),

                  // Bottom Telemetry & Progress
                  Column(
                    children: [
                      SplashStatusText(statusMessage: status),
                      const SizedBox(height: AppDimensions.p12),
                      SplashProgressBar(progress: progress),
                      const SizedBox(height: AppDimensions.p8),
                      Text(
                        'v1.0 • QUEENS SECTOR NETWORK',
                        style: AppTextStyles.telemetry(AppColors.pixelBlack)
                            .copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
