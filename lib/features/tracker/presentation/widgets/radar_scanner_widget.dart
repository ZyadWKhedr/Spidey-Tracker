import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/pixel_border_card.dart';
import '../cubit/tracker_cubit.dart';
import '../cubit/tracker_state.dart';

class RadarScannerWidget extends StatelessWidget {
  const RadarScannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackerCubit, TrackerState>(
      builder: (context, state) {
        return PixelBorderCard(
          padding: const EdgeInsets.all(AppDimensions.p16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SPIDER-RADAR',
                    style: AppTextStyles.headlineSmall(context).copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    AppStrings.radarRange,
                    style: AppTextStyles.telemetry(
                      AppColors.primarySkyBlueDark,
                    ).copyWith(fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.p16),

              // Radar Circular Visual
              SizedBox(
                height: 160,
                width: 160,
                child: CustomPaint(
                  painter: _RadarGridPainter(
                    isScanning: state.isScanning,
                    alertCount: state.activeAlertsCount,
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.p16),

              // Action Buttons: Scan Sector & Open Full Map
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton.icon(
                      onPressed: state.isScanning
                          ? null
                          : () => context.read<TrackerCubit>().scanRadar(),
                      icon: state.isScanning
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(
                                  AppColors.pixelBlack,
                                ),
                              ),
                            )
                          : const Icon(Icons.refresh, size: 16),
                      label: Text(
                        state.isScanning ? 'SCANNING' : 'PING',
                        style: AppTextStyles.headlineSmall(context).copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: AppColors.pixelBlack,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.pixelBlack,
                        side: const BorderSide(
                          color: AppColors.pixelBlack,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppDimensions.radiusSm),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimensions.p12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.p8),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.radarMap);
                      },
                      icon: const Icon(Icons.map_outlined, size: 18),
                      label: Text(
                        'OPEN SPIDEY MAP',
                        style: AppTextStyles.headlineSmall(context).copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: AppColors.pixelBlack,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primarySkyBlue,
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
                          vertical: AppDimensions.p12,
                        ),
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

class _RadarGridPainter extends CustomPainter {
  final bool isScanning;
  final int alertCount;

  _RadarGridPainter({
    required this.isScanning,
    required this.alertCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final gridPaint = Paint()
      ..color = AppColors.primarySkyBlue.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Outer circle & inner concentric rings
    canvas.drawCircle(center, radius, gridPaint);
    canvas.drawCircle(center, radius * 0.66, gridPaint);
    canvas.drawCircle(center, radius * 0.33, gridPaint);

    // Crosshairs
    canvas.drawLine(
      Offset(0, center.dy),
      Offset(size.width, center.dy),
      gridPaint,
    );
    canvas.drawLine(
      Offset(center.dx, 0),
      Offset(center.dx, size.height),
      gridPaint,
    );

    // Spider-Man center point
    final spideyCenterPaint = Paint()
      ..color = AppColors.spideyRed
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 4.5, spideyCenterPaint);

    // Blips for alerts
    final alertPaint = Paint()
      ..color = AppColors.alertOrange
      ..style = PaintingStyle.fill;

    if (alertCount > 0) {
      canvas.drawCircle(
        Offset(center.dx + radius * 0.45, center.dy - radius * 0.35),
        5,
        alertPaint,
      );
    }
    if (alertCount > 1) {
      canvas.drawCircle(
        Offset(center.dx - radius * 0.55, center.dy - radius * 0.2),
        5,
        alertPaint,
      );
    }
    if (alertCount > 2) {
      canvas.drawCircle(
        Offset(center.dx + radius * 0.25, center.dy + radius * 0.55),
        5,
        Paint()..color = AppColors.spideyRed,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RadarGridPainter oldDelegate) {
    return oldDelegate.isScanning != isScanning ||
        oldDelegate.alertCount != alertCount;
  }
}
