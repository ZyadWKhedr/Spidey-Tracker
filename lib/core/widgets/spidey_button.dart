import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../theme/app_text_styles.dart';

class SpideyButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final bool isLoading;

  const SpideyButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppColors.primarySkyBlue,
    this.textColor = AppColors.pixelBlack,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.p16,
            vertical: AppDimensions.p12,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            border: Border.all(
              color: AppColors.pixelBlack,
              width: AppDimensions.pixelBorderWidth,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.pixelBlack,
                offset: Offset(2, 3),
                blurRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(AppColors.pixelBlack),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, color: textColor, size: 18),
                        const SizedBox(width: AppDimensions.p8),
                      ],
                      Text(
                        label,
                        style: AppTextStyles.headlineSmall(context).copyWith(
                          color: textColor,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
