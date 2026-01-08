import 'dart:math' as math;
import 'package:flutter/material.dart';

/// High-performance particle system for ambient effects
class ParticleSystem extends StatefulWidget {
  final int particleCount;
  final Color particleColor;
  final double maxParticleSize;
  final double minParticleSize;
  final bool enableGlow;

  const ParticleSystem({
    super.key,
    this.particleCount = 30,
    this.particleColor = Colors.white,
    this.maxParticleSize = 3.0,
    this.minParticleSize = 1.0,
    this.enableGlow = true,
  });

  @override
  State<ParticleSystem> createState() => _ParticleSystemState();
}

class _ParticleSystemState extends State<ParticleSystem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Particle> _particles;
  final _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _particles = List.generate(widget.particleCount, (_) => _generateParticle());
  }

  _Particle _generateParticle() {
    return _Particle(
      x: _random.nextDouble(),
      y: _random.nextDouble(),
      size: _random.nextDouble() *
              (widget.maxParticleSize - widget.minParticleSize) +
          widget.minParticleSize,
      speedX: (_random.nextDouble() - 0.5) * 0.02,
      speedY: (_random.nextDouble() - 0.5) * 0.02,
      opacity: _random.nextDouble() * 0.5 + 0.2,
      twinkleSpeed: _random.nextDouble() * 2 + 1,
      twinklePhase: _random.nextDouble() * math.pi * 2,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _ParticlePainter(
            particles: _particles,
            color: widget.particleColor,
            animationValue: _controller.value,
            enableGlow: widget.enableGlow,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _Particle {
  double x;
  double y;
  final double size;
  final double speedX;
  final double speedY;
  final double opacity;
  final double twinkleSpeed;
  final double twinklePhase;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speedX,
    required this.speedY,
    required this.opacity,
    required this.twinkleSpeed,
    required this.twinklePhase,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final Color color;
  final double animationValue;
  final bool enableGlow;

  _ParticlePainter({
    required this.particles,
    required this.color,
    required this.animationValue,
    required this.enableGlow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      // Update position with wrapping
      particle.x += particle.speedX;
      particle.y += particle.speedY;
      if (particle.x < 0) particle.x = 1;
      if (particle.x > 1) particle.x = 0;
      if (particle.y < 0) particle.y = 1;
      if (particle.y > 1) particle.y = 0;

      // Calculate twinkle
      final twinkle = (math.sin(
                animationValue * math.pi * 2 * particle.twinkleSpeed +
                    particle.twinklePhase,
              ) +
              1) /
          2;

      final currentOpacity = particle.opacity * (0.5 + twinkle * 0.5);

      final position = Offset(
        particle.x * size.width,
        particle.y * size.height,
      );

      if (enableGlow) {
        final glowPaint = Paint()
          ..color = color.withValues(alpha: currentOpacity * 0.3)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, particle.size * 2);
        canvas.drawCircle(position, particle.size * 2, glowPaint);
      }

      final paint = Paint()..color = color.withValues(alpha: currentOpacity);
      canvas.drawCircle(position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter oldDelegate) => true;
}
