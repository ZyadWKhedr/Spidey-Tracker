import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/pixel_border_card.dart';
import '../../../../core/widgets/spidey_badge.dart';
import '../../domain/entities/crime_alert.dart';

class CrimeAlertCard extends StatelessWidget {
  final CrimeAlert alert;
  final VoidCallback onResolve;

  const CrimeAlertCard({
    super.key,
    required this.alert,
    required this.onResolve,
  });

  Color _getSeverityColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.critical:
        return AppColors.spideyRed;
      case AlertSeverity.high:
        return AppColors.alertOrange;
      case AlertSeverity.medium:
        return AppColors.primarySkyBlue;
      case AlertSeverity.low:
        return AppColors.badgeCreamDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final severityColor = _getSeverityColor(alert.severity);

    return Opacity(
      opacity: alert.isResolved ? 0.5 : 1.0,
      child: PixelBorderCard(
        padding: const EdgeInsets.all(AppDimensions.p12),
        borderColor: alert.isResolved
            ? AppColors.patrolGreen
            : (alert.severity == AlertSeverity.critical
                ? AppColors.spideyRed
                : null),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: ID & Severity & Timestamp
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SpideyBadge(
                      label: alert.severity.name,
                      backgroundColor: severityColor,
                      textColor: alert.severity == AlertSeverity.critical
                          ? Colors.white
                          : AppColors.pixelBlack,
                    ),
                    const SizedBox(width: AppDimensions.p8),
                    Text(
                      alert.id,
                      style: AppTextStyles.telemetry(
                        Theme.of(context).brightness == Brightness.dark
                            ? AppColors.primarySkyBlueLight
                            : AppColors.textSecondaryLight,
                      ).copyWith(fontSize: 11),
                    ),
                  ],
                ),
                Text(
                  alert.timestamp,
                  style: AppTextStyles.bodySmall(context),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.p8),

            // Title & Location
            Text(
              alert.title,
              style: AppTextStyles.headlineSmall(context).copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                decoration:
                    alert.isResolved ? TextDecoration.lineThrough : null,
              ),
            ),
            const SizedBox(height: AppDimensions.p4),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: AppColors.spideyRed,
                ),
                const SizedBox(width: 4),
                Text(
                  alert.location,
                  style: AppTextStyles.bodySmall(context).copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.p8),

            // Description
            Text(
              alert.description,
              style: AppTextStyles.bodyMedium(context).copyWith(fontSize: 13),
            ),
            const SizedBox(height: AppDimensions.p12),

            // Resolve Button
            Align(
              alignment: Alignment.centerRight,
              child: alert.isResolved
                  ? const SpideyBadge(
                      label: 'RESOLVED ✓',
                      backgroundColor: AppColors.patrolGreen,
                      textColor: Colors.white,
                    )
                  : OutlinedButton.icon(
                      onPressed: onResolve,
                      icon: const Icon(Icons.shield_outlined, size: 14),
                      label: const Text('WEB & SECURE'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.spideyRed,
                        side: const BorderSide(
                          color: AppColors.pixelBlack,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppDimensions.radiusSm),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.p12,
                          vertical: AppDimensions.p8,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
