import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SplashStatusText extends StatelessWidget {
  final String statusMessage;

  const SplashStatusText({
    super.key,
    required this.statusMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          statusMessage.toUpperCase(),
          textAlign: TextAlign.center,
          style: AppTextStyles.telemetry(AppColors.pixelBlack).copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
