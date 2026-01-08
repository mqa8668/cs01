import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Animated cosmic background with stars and nebula effects
class CosmicBackground extends StatefulWidget {
  final Widget? child;
  final bool animate;
  final int starCount;

  const CosmicBackground({
    super.key,
    this.child,
    this.animate = true,
    this.starCount = 50,
  });

  @override
  State<CosmicBackground> createState() => _CosmicBackgroundState();
}

class _CosmicBackgroundState extends State<CosmicBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Star> _stars;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _stars = List.generate(widget.starCount, (_) => _Star.random());

    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.backgroundGradientDark,
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),

        // Animated stars
        if (widget.animate)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _StarPainter(
                  stars: _stars,
                  animationValue: _controller.value,
                ),
                size: Size.infinite,
              );
            },
          )
        else
          CustomPaint(
            painter: _StarPainter(
              stars: _stars,
              animationValue: 0,
            ),
            size: Size.infinite,
          ),

        // Nebula overlay
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(-0.5, -0.5),
              radius: 1.5,
              colors: [
                AppColors.dark.nebulaGlow,
                Colors.transparent,
              ],
            ),
          ),
        ),

        // Second nebula
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.7, 0.8),
              radius: 1.2,
              colors: [
                AppColors.dark.tertiary.withValues(alpha: 0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),

        // Child content
        if (widget.child != null) widget.child!,
      ],
    );
  }
}

class _Star {
  final double x;
  final double y;
  final double size;
  final double twinkleSpeed;
  final double twinklePhase;

  _Star({
    required this.x,
    required this.y,
    required this.size,
    required this.twinkleSpeed,
    required this.twinklePhase,
  });

  factory _Star.random() {
    final random = math.Random();
    return _Star(
      x: random.nextDouble(),
      y: random.nextDouble(),
      size: random.nextDouble() * 2 + 0.5,
      twinkleSpeed: random.nextDouble() * 2 + 0.5,
      twinklePhase: random.nextDouble() * math.pi * 2,
    );
  }
}

class _StarPainter extends CustomPainter {
  final List<_Star> stars;
  final double animationValue;

  _StarPainter({
    required this.stars,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      final twinkle = (math.sin(
                animationValue * math.pi * 2 * star.twinkleSpeed +
                    star.twinklePhase,
              ) +
              1) /
          2;

      final opacity = 0.3 + twinkle * 0.7;
      final glowSize = star.size * (1 + twinkle * 0.5);

      final paint = Paint()
        ..color = AppColors.dark.starGlow.withValues(alpha: opacity)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowSize);

      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size,
        paint,
      );

      // Core
      final corePaint = Paint()
        ..color = Colors.white.withValues(alpha: opacity);

      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size * 0.3,
        corePaint,
      );
    }
  }

  @override
  bool shouldRepaint(_StarPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue;
  }
}
