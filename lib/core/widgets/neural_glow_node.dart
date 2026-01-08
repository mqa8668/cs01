import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Animated neural network node with glow effect
class NeuralGlowNode extends StatefulWidget {
  final double size;
  final Color? coreColor;
  final Color? glowColor;
  final bool animate;
  final Duration animationDuration;
  final VoidCallback? onTap;

  const NeuralGlowNode({
    super.key,
    this.size = 20,
    this.coreColor,
    this.glowColor,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 2000),
    this.onTap,
  });

  @override
  State<NeuralGlowNode> createState() => _NeuralGlowNodeState();
}

class _NeuralGlowNodeState extends State<NeuralGlowNode>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.animate) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveCoreColor = widget.coreColor ??
        (isDark ? AppColors.dark.nodeGlow : AppColors.light.nodeGlow);
    final effectiveGlowColor = widget.glowColor ??
        (isDark ? AppColors.dark.neuralCyan : AppColors.light.neuralCyan);

    Widget node = AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        final glowIntensity = widget.animate ? _pulseAnimation.value : 0.8;

        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: effectiveCoreColor,
            boxShadow: [
              // Outer glow
              BoxShadow(
                color: effectiveGlowColor.withValues(alpha: 0.3 * glowIntensity),
                blurRadius: widget.size * 1.5 * glowIntensity,
                spreadRadius: widget.size * 0.2,
              ),
              // Inner glow
              BoxShadow(
                color: effectiveGlowColor.withValues(alpha: 0.6 * glowIntensity),
                blurRadius: widget.size * 0.5 * glowIntensity,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: widget.size * 0.4,
              height: widget.size * 0.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: glowIntensity),
              ),
            ),
          ),
        );
      },
    );

    if (widget.onTap != null) {
      node = GestureDetector(
        onTap: widget.onTap,
        child: node,
      );
    }

    return node;
  }
}

/// Static node without animation (for performance when many nodes needed)
class StaticNeuralNode extends StatelessWidget {
  final double size;
  final Color? coreColor;
  final Color? glowColor;
  final double glowIntensity;

  const StaticNeuralNode({
    super.key,
    this.size = 20,
    this.coreColor,
    this.glowColor,
    this.glowIntensity = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveCoreColor =
        coreColor ?? (isDark ? AppColors.dark.nodeGlow : AppColors.light.nodeGlow);
    final effectiveGlowColor = glowColor ??
        (isDark ? AppColors.dark.neuralCyan : AppColors.light.neuralCyan);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: effectiveCoreColor,
        boxShadow: [
          BoxShadow(
            color: effectiveGlowColor.withValues(alpha: 0.3 * glowIntensity),
            blurRadius: size * 1.5 * glowIntensity,
            spreadRadius: size * 0.2,
          ),
          BoxShadow(
            color: effectiveGlowColor.withValues(alpha: 0.6 * glowIntensity),
            blurRadius: size * 0.5 * glowIntensity,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: size * 0.4,
          height: size * 0.4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: glowIntensity),
          ),
        ),
      ),
    );
  }
}
