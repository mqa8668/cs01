import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';

/// Production-grade Mind Garden with 31 animated flowers
class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen>
    with TickerProviderStateMixin {
  late AnimationController _swayController;
  late AnimationController _growController;
  late AnimationController _glowController;
  late AnimationController _particleController;

  final List<GardenFlower> _flowers = [];
  final _random = math.Random(42);

  @override
  void initState() {
    super.initState();

    _swayController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _growController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _initializeFlowers();
  }

  void _initializeFlowers() {
    final flowerTypes = [
      ('Gratitude Rose', const Color(0xFFFF6B9D), const Color(0xFFFF8FB1), FlowerType.rose, 5),
      ('Calm Lavender', const Color(0xFFAA80FF), const Color(0xFFC4A8FF), FlowerType.lavender, 4),
      ('Joy Sunflower', const Color(0xFFFFD93D), const Color(0xFFFFE066), FlowerType.sunflower, 3),
      ('Peace Lily', const Color(0xFFFFFFFF), const Color(0xFFF0F0FF), FlowerType.lily, 4),
      ('Hope Tulip', const Color(0xFFFF69B4), const Color(0xFFFF85C0), FlowerType.tulip, 5),
      ('Love Peony', const Color(0xFFFFB5C5), const Color(0xFFFFCDD8), FlowerType.peony, 3),
      ('Wisdom Orchid', const Color(0xFF9B59B6), const Color(0xFFB47CC9), FlowerType.orchid, 4),
      ('Energy Daisy', const Color(0xFF4ECDC4), const Color(0xFF7EDDD6), FlowerType.daisy, 3),
    ];

    int index = 0;
    for (final type in flowerTypes) {
      for (int i = 0; i < type.$5; i++) {
        final growthStage = _random.nextDouble();
        _flowers.add(GardenFlower(
          id: index,
          name: type.$1,
          primaryColor: type.$2,
          secondaryColor: type.$3,
          type: type.$4,
          growthStage: growthStage,
          x: _random.nextDouble() * 0.8 + 0.1,
          y: _random.nextDouble() * 0.6 + 0.2,
          size: 40 + _random.nextDouble() * 30,
          swayPhase: _random.nextDouble() * math.pi * 2,
          swayAmplitude: 0.02 + _random.nextDouble() * 0.03,
          bloomedAt: growthStage > 0.8
              ? DateTime.now().subtract(Duration(days: _random.nextInt(14)))
              : null,
        ));
        index++;
      }
    }

    // Sort by Y position for proper layering
    _flowers.sort((a, b) => a.y.compareTo(b.y));
  }

  @override
  void dispose() {
    _swayController.dispose();
    _growController.dispose();
    _glowController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bloomedCount = _flowers.where((f) => f.growthStage > 0.8).length;

    return ThemedBackground(
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GradientText(
                        text: 'Mind Garden',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$bloomedCount of ${_flowers.length} flowers bloomed',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppColors.dark.textSecondary
                              : AppColors.light.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  _buildGardenHealth(isDark),
                ],
              ),
            ),

            // Garden Visualization
            Expanded(
              child: Stack(
                children: [
                  // Floating particles
                  AnimatedBuilder(
                    animation: _particleController,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: GardenParticlePainter(
                          animationValue: _particleController.value,
                          isDark: isDark,
                        ),
                        size: Size.infinite,
                      );
                    },
                  ),

                  // Flowers
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _swayController,
                      _growController,
                      _glowController,
                    ]),
                    builder: (context, child) {
                      return CustomPaint(
                        painter: GardenPainter(
                          flowers: _flowers,
                          swayValue: _swayController.value,
                          growValue: _growController.value,
                          glowValue: _glowController.value,
                          isDark: isDark,
                        ),
                        size: Size.infinite,
                      );
                    },
                  ),
                ],
              ),
            ),

            // Bottom Stats
            _buildStatsPanel(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildGardenHealth(bool isDark) {
    final bloomedCount = _flowers.where((f) => f.growthStage > 0.8).length;
    final healthPercent = (bloomedCount / _flowers.length * 100).round();

    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        final glowIntensity = 0.3 + _glowController.value * 0.3;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF7FFF7F).withValues(alpha: 0.2),
                const Color(0xFF4ECDC4).withValues(alpha: 0.2),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.green.withValues(alpha: glowIntensity),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withValues(alpha: glowIntensity * 0.5),
                blurRadius: 15,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.eco,
                color: Colors.green,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '$healthPercent%',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatsPanel(bool isDark) {
    final bloomedFlowers = _flowers.where((f) => f.growthStage > 0.8).toList();
    final growingFlowers = _flowers.where((f) => f.growthStage > 0.3 && f.growthStage <= 0.8).toList();
    final seedlings = _flowers.where((f) => f.growthStage <= 0.3).toList();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.dark.cardBackground.withValues(alpha: 0.8)
            : AppColors.light.cardBackground.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.dark.cardBorder : AppColors.light.cardBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFlowerStat('Bloomed', '${bloomedFlowers.length}', const Color(0xFFFF6B9D), Icons.local_florist),
              _buildFlowerStat('Growing', '${growingFlowers.length}', const Color(0xFF4ECDC4), Icons.grass),
              _buildFlowerStat('Seeds', '${seedlings.length}', const Color(0xFFFFD93D), Icons.grain),
            ],
          ),
          const SizedBox(height: 16),
          // Recent activity
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wb_sunny,
                size: 16,
                color: isDark ? AppColors.dark.textSecondary : AppColors.light.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                '7-day streak! Keep nurturing your garden',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? AppColors.dark.textSecondary : AppColors.light.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFlowerStat(String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.dark.textSecondary
                : AppColors.light.textSecondary,
          ),
        ),
      ],
    );
  }
}

enum FlowerType { rose, lavender, sunflower, lily, tulip, peony, orchid, daisy }

class GardenFlower {
  final int id;
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final FlowerType type;
  final double growthStage;
  final double x;
  final double y;
  final double size;
  final double swayPhase;
  final double swayAmplitude;
  final DateTime? bloomedAt;

  GardenFlower({
    required this.id,
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.type,
    required this.growthStage,
    required this.x,
    required this.y,
    required this.size,
    required this.swayPhase,
    required this.swayAmplitude,
    this.bloomedAt,
  });
}

class GardenPainter extends CustomPainter {
  final List<GardenFlower> flowers;
  final double swayValue;
  final double growValue;
  final double glowValue;
  final bool isDark;

  GardenPainter({
    required this.flowers,
    required this.swayValue,
    required this.growValue,
    required this.glowValue,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final flower in flowers) {
      final x = flower.x * size.width;
      final y = flower.y * size.height;

      // Calculate sway offset
      final sway = math.sin(swayValue * math.pi * 2 + flower.swayPhase) *
          flower.swayAmplitude *
          size.width;

      final flowerX = x + sway;
      final currentGrowth = flower.growthStage * growValue;
      final flowerSize = flower.size * currentGrowth;

      if (currentGrowth < 0.1) continue;

      // Draw stem
      _drawStem(canvas, flowerX, y, flowerSize, flower, sway);

      // Draw flower based on growth stage
      if (currentGrowth > 0.3) {
        _drawFlower(canvas, flowerX, y - flowerSize * 0.8, flowerSize, flower);
      }
    }
  }

  void _drawStem(Canvas canvas, double x, double y, double size, GardenFlower flower, double sway) {
    final stemPaint = Paint()
      ..color = const Color(0xFF2D5A27)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(x, y + size * 0.5);

    // Curved stem
    path.quadraticBezierTo(
      x + sway * 0.5,
      y,
      x,
      y - size * 0.6,
    );

    canvas.drawPath(path, stemPaint);

    // Draw leaves
    if (flower.growthStage > 0.5) {
      final leafPaint = Paint()
        ..color = const Color(0xFF3D7A37)
        ..style = PaintingStyle.fill;

      // Left leaf
      final leftLeaf = Path();
      leftLeaf.moveTo(x - 2, y);
      leftLeaf.quadraticBezierTo(x - size * 0.3, y - size * 0.1, x - size * 0.2, y + size * 0.1);
      leftLeaf.quadraticBezierTo(x - size * 0.1, y + size * 0.05, x - 2, y);
      canvas.drawPath(leftLeaf, leafPaint);

      // Right leaf
      final rightLeaf = Path();
      rightLeaf.moveTo(x + 2, y - size * 0.2);
      rightLeaf.quadraticBezierTo(x + size * 0.3, y - size * 0.3, x + size * 0.2, y - size * 0.1);
      rightLeaf.quadraticBezierTo(x + size * 0.1, y - size * 0.15, x + 2, y - size * 0.2);
      canvas.drawPath(rightLeaf, leafPaint);
    }
  }

  void _drawFlower(Canvas canvas, double x, double y, double size, GardenFlower flower) {
    final petalCount = switch (flower.type) {
      FlowerType.rose => 12,
      FlowerType.lavender => 6,
      FlowerType.sunflower => 16,
      FlowerType.lily => 6,
      FlowerType.tulip => 6,
      FlowerType.peony => 20,
      FlowerType.orchid => 5,
      FlowerType.daisy => 12,
    };

    final petalSize = size * (flower.growthStage > 0.8 ? 0.5 : 0.35);
    final glowIntensity = flower.growthStage > 0.8 ? glowValue : 0;

    // Glow effect for bloomed flowers
    if (flower.growthStage > 0.8) {
      final glowPaint = Paint()
        ..color = flower.primaryColor.withValues(alpha: 0.2 + glowIntensity * 0.2)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, petalSize);
      canvas.drawCircle(Offset(x, y), petalSize * 1.5, glowPaint);
    }

    // Draw petals
    for (int i = 0; i < petalCount; i++) {
      final angle = (i / petalCount) * math.pi * 2 - math.pi / 2;
      final petalX = x + math.cos(angle) * petalSize * 0.5;
      final petalY = y + math.sin(angle) * petalSize * 0.5;

      final petalPaint = Paint()
        ..shader = RadialGradient(
          colors: [flower.secondaryColor, flower.primaryColor],
        ).createShader(Rect.fromCircle(center: Offset(petalX, petalY), radius: petalSize * 0.4));

      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(petalX, petalY),
          width: petalSize * 0.5,
          height: petalSize * 0.7,
        ),
        petalPaint,
      );
    }

    // Center
    final centerPaint = Paint()
      ..color = flower.type == FlowerType.sunflower
          ? const Color(0xFF8B4513)
          : const Color(0xFFFFE066);
    canvas.drawCircle(Offset(x, y), petalSize * 0.25, centerPaint);

    // Highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6);
    canvas.drawCircle(
      Offset(x - petalSize * 0.08, y - petalSize * 0.08),
      petalSize * 0.08,
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(GardenPainter oldDelegate) {
    return swayValue != oldDelegate.swayValue ||
        growValue != oldDelegate.growValue ||
        glowValue != oldDelegate.glowValue;
  }
}

class GardenParticlePainter extends CustomPainter {
  final double animationValue;
  final bool isDark;

  GardenParticlePainter({
    required this.animationValue,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);

    // Floating pollen/sparkles
    for (int i = 0; i < 20; i++) {
      final baseX = random.nextDouble();
      final baseY = random.nextDouble();
      final particlePhase = random.nextDouble() * math.pi * 2;
      final particleSpeed = 0.5 + random.nextDouble() * 0.5;

      final x = baseX * size.width +
          math.sin(animationValue * math.pi * 2 * particleSpeed + particlePhase) * 20;
      final y = ((baseY + animationValue * particleSpeed) % 1.0) * size.height;

      final opacity = (math.sin(animationValue * math.pi * 4 + particlePhase) + 1) / 2 * 0.6;

      final paint = Paint()
        ..color = (isDark ? Colors.white : const Color(0xFFFFE066)).withValues(alpha: opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

      canvas.drawCircle(Offset(x, y), 2 + random.nextDouble() * 2, paint);
    }
  }

  @override
  bool shouldRepaint(GardenParticlePainter oldDelegate) {
    return animationValue != oldDelegate.animationValue;
  }
}
