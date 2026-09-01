import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class PixelBorderCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final VoidCallback? onTap;

  const PixelBorderCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = AppDimensions.pixelBorderWidth,
    this.borderRadius = AppDimensions.radiusMd,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBorderColor = borderColor ??
        (isDark ? AppColors.darkBorder : AppColors.pixelBlack);
    final effectiveBgColor = backgroundColor ??
        (isDark ? AppColors.darkSurface : AppColors.lightSurface);

    Widget content = Container(
      padding: padding ?? const EdgeInsets.all(AppDimensions.p16),
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: effectiveBorderColor,
          width: borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.5)
                : AppColors.pixelBlack.withValues(alpha: 0.12),
            offset: const Offset(3, 4),
            blurRadius: 0, // Crisp comic shadow
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }
}
