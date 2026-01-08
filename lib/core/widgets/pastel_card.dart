import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Soft-edged card with optional frosted glass effect
class PastelCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool frosted;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  const PastelCard({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.frosted = false,
    this.width,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBackgroundColor = backgroundColor ??
        (frosted
            ? (isDark
                ? AppColors.dark.glassBackground
                : Colors.white.withValues(alpha: 0.7))
            : (isDark
                ? AppColors.dark.cardBackground
                : AppColors.light.cardBackground));
    final effectiveBorderColor = borderColor ??
        (isDark ? AppColors.dark.cardBorder : AppColors.light.cardBorder);

    Widget card = Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: frosted ? null : effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: effectiveBorderColor,
          width: 1,
        ),
        boxShadow: frosted
            ? null
            : [
                BoxShadow(
                  color: isDark
                      ? AppColors.dark.shadowColor
                      : AppColors.light.shadowColor,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: frosted
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: effectiveBackgroundColor,
                  padding: padding ?? const EdgeInsets.all(16),
                  child: child,
                ),
              ),
            )
          : Padding(
              padding: padding ?? const EdgeInsets.all(16),
              child: child,
            ),
    );

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: card,
      );
    }

    return card;
  }
}
