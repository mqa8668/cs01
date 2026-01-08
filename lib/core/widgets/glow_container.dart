import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Container with customizable glow effect
class GlowContainer extends StatelessWidget {
  final Widget child;
  final Color? glowColor;
  final double glowRadius;
  final double glowSpread;
  final double borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const GlowContainer({
    super.key,
    required this.child,
    this.glowColor,
    this.glowRadius = 20,
    this.glowSpread = 2,
    this.borderRadius = 16,
    this.backgroundColor,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveGlowColor = glowColor ??
        (isDark ? AppColors.dark.shadowColor : AppColors.light.shadowColor);
    final effectiveBackgroundColor = backgroundColor ??
        (isDark
            ? AppColors.dark.cardBackground
            : AppColors.light.cardBackground);

    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: effectiveGlowColor,
            blurRadius: glowRadius,
            spreadRadius: glowSpread,
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Animated pulsing glow container
class PulsingGlowContainer extends StatefulWidget {
  final Widget child;
  final Color? glowColor;
  final double minGlowRadius;
  final double maxGlowRadius;
  final Duration duration;
  final double borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const PulsingGlowContainer({
    super.key,
    required this.child,
    this.glowColor,
    this.minGlowRadius = 10,
    this.maxGlowRadius = 25,
    this.duration = const Duration(milliseconds: 2000),
    this.borderRadius = 16,
    this.backgroundColor,
    this.padding,
  });

  @override
  State<PulsingGlowContainer> createState() => _PulsingGlowContainerState();
}

class _PulsingGlowContainerState extends State<PulsingGlowContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _glowAnimation = Tween<double>(
      begin: widget.minGlowRadius,
      end: widget.maxGlowRadius,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveGlowColor = widget.glowColor ??
        (isDark ? AppColors.dark.neuralCyan : AppColors.light.primary);
    final effectiveBackgroundColor = widget.backgroundColor ??
        (isDark
            ? AppColors.dark.cardBackground
            : AppColors.light.cardBackground);

    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              BoxShadow(
                color: effectiveGlowColor.withValues(alpha: 0.5),
                blurRadius: _glowAnimation.value,
                spreadRadius: 1,
              ),
            ],
          ),
          child: widget.child,
        );
      },
    );
  }
}
