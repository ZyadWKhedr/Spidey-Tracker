import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/tracker_cubit.dart';
import '../cubit/tracker_state.dart';
import 'crime_alert_card.dart';

class CrimeAlertList extends StatelessWidget {
  const CrimeAlertList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackerCubit, TrackerState>(
      builder: (context, state) {
        final alerts = state.alerts;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.radio_outlined,
                      size: 18,
                      color: AppColors.spideyRed,
                    ),
                    const SizedBox(width: AppDimensions.p8),
                    Text(
                      AppStrings.liveAlerts,
                      style: AppTextStyles.headlineSmall(context).copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${alerts.length} TOTAL',
                  style: AppTextStyles.telemetry(
                    AppColors.textSecondaryLight,
                  ).copyWith(fontSize: 11),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.p12),

            // Alerts List
            if (alerts.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.p24),
                  child: Text(
                    'No active dispatches. Queens is secure!',
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: alerts.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppDimensions.p12),
                itemBuilder: (context, index) {
                  final alert = alerts[index];
                  return CrimeAlertCard(
                    alert: alert,
                    onResolve: () {
                      context.read<TrackerCubit>().resolveAlert(alert.id);
                    },
                  );
                },
              ),
          ],
        );
      },
    );
  }
}
