import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/widgets.dart';

/// Production-grade Neural Map with 35 animated nodes
class NeuralMapScreen extends ConsumerStatefulWidget {
  const NeuralMapScreen({super.key});

  @override
  ConsumerState<NeuralMapScreen> createState() => _NeuralMapScreenState();
}

class _NeuralMapScreenState extends ConsumerState<NeuralMapScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late AnimationController _connectionController;

  // Neural node data - 35 nodes representing brain regions
  final List<NeuralNode> _nodes = [];
  final List<NeuralConnection> _connections = [];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();

    _connectionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    _initializeNodes();
  }

  void _initializeNodes() {
    final random = math.Random(42); // Fixed seed for consistent layout

    // Brain region categories with colors
    final regions = [
      ('Prefrontal', const Color(0xFF00D4FF), 7),   // Cyan - executive function
      ('Motor', const Color(0xFFFF69B4), 5),         // Pink - movement
      ('Sensory', const Color(0xFFAA80FF), 6),       // Purple - perception
      ('Limbic', const Color(0xFFFFB347), 5),        // Orange - emotion
      ('Memory', const Color(0xFF7FFF7F), 6),        // Green - hippocampus
      ('Visual', const Color(0xFFFF6B6B), 4),        // Red - occipital
      ('Language', const Color(0xFF4ECDC4), 2),      // Teal - Broca/Wernicke
    ];

    int nodeIndex = 0;
    for (final region in regions) {
      final regionName = region.$1;
      final color = region.$2;
      final count = region.$3;

      for (int i = 0; i < count; i++) {
        // Distribute nodes in a brain-like shape
        final angle = (nodeIndex / 35) * math.pi * 2 + random.nextDouble() * 0.5;
        final radius = 0.25 + random.nextDouble() * 0.2;

        _nodes.add(NeuralNode(
          id: nodeIndex,
          name: '$regionName ${i + 1}',
          region: regionName,
          x: 0.5 + math.cos(angle) * radius,
          y: 0.5 + math.sin(angle) * radius * 0.8, // Slightly oval
          color: color,
          size: 8 + random.nextDouble() * 8,
          pulsePhase: random.nextDouble() * math.pi * 2,
          activityLevel: 0.3 + random.nextDouble() * 0.7,
        ));
        nodeIndex++;
      }
    }

    // Create connections between nearby nodes
    for (int i = 0; i < _nodes.length; i++) {
      for (int j = i + 1; j < _nodes.length; j++) {
        final dx = _nodes[i].x - _nodes[j].x;
        final dy = _nodes[i].y - _nodes[j].y;
        final distance = math.sqrt(dx * dx + dy * dy);

        // Connect nodes that are close enough
        if (distance < 0.25 && random.nextDouble() > 0.3) {
          _connections.add(NeuralConnection(
            from: i,
            to: j,
            strength: random.nextDouble(),
          ));
        }
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    _connectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                        text: 'Neural Map',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '35 Active Nodes',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppColors.dark.textSecondary
                              : AppColors.light.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildActivityIndicator(),
                      const SizedBox(width: 12),
                      IconButton(
                        onPressed: () {
                          ref.read(themeProvider.notifier).toggleTheme();
                        },
                        icon: Icon(
                          themeState.mode == AppThemeMode.dark
                              ? Icons.light_mode
                              : Icons.dark_mode,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Neural Map Visualization
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AnimatedBuilder(
                  animation: Listenable.merge([
                    _pulseController,
                    _rotationController,
                    _connectionController,
                  ]),
                  builder: (context, child) {
                    return CustomPaint(
                      painter: NeuralMapPainter(
                        nodes: _nodes,
                        connections: _connections,
                        pulseValue: _pulseController.value,
                        rotationValue: _rotationController.value,
                        connectionValue: _connectionController.value,
                        isDark: isDark,
                      ),
                      size: Size.infinite,
                    );
                  },
                ),
              ),
            ),

            // Bottom Info Panel
            _buildInfoPanel(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityIndicator() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.green.withValues(alpha: 0.5 + _pulseController.value * 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: _pulseController.value),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'Active',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoPanel(bool isDark) {
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
            color: isDark
                ? AppColors.dark.neuralCyan.withValues(alpha: 0.1)
                : AppColors.light.primary.withValues(alpha: 0.1),
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
              _buildStat('Nodes', '35', AppColors.dark.neuralCyan),
              _buildStat('Connections', '${_connections.length}', AppColors.dark.neuralPink),
              _buildStat('Activity', '87%', AppColors.dark.neuralPurple),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Neural pathways synchronized',
            style: TextStyle(
              fontSize: 13,
              color: isDark
                  ? AppColors.dark.textSecondary
                  : AppColors.light.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.dark.textSecondary
                : AppColors.light.textSecondary,
          ),
        ),
      ],
    );
  }
}

class NeuralNode {
  final int id;
  final String name;
  final String region;
  final double x;
  final double y;
  final Color color;
  final double size;
  final double pulsePhase;
  final double activityLevel;

  NeuralNode({
    required this.id,
    required this.name,
    required this.region,
    required this.x,
    required this.y,
    required this.color,
    required this.size,
    required this.pulsePhase,
    required this.activityLevel,
  });
}

class NeuralConnection {
  final int from;
  final int to;
  final double strength;

  NeuralConnection({
    required this.from,
    required this.to,
    required this.strength,
  });
}

class NeuralMapPainter extends CustomPainter {
  final List<NeuralNode> nodes;
  final List<NeuralConnection> connections;
  final double pulseValue;
  final double rotationValue;
  final double connectionValue;
  final bool isDark;

  NeuralMapPainter({
    required this.nodes,
    required this.connections,
    required this.pulseValue,
    required this.rotationValue,
    required this.connectionValue,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final scale = math.min(size.width, size.height);

    // Draw connections first (below nodes)
    for (final connection in connections) {
      final from = nodes[connection.from];
      final to = nodes[connection.to];

      final fromPos = Offset(
        center.dx + (from.x - 0.5) * scale,
        center.dy + (from.y - 0.5) * scale,
      );
      final toPos = Offset(
        center.dx + (to.x - 0.5) * scale,
        center.dy + (to.y - 0.5) * scale,
      );

      // Animated connection with flowing particles effect
      final flowPosition = (connectionValue + connection.strength) % 1.0;

      // Base connection line
      final connectionPaint = Paint()
        ..color = Color.lerp(from.color, to.color, 0.5)!
            .withValues(alpha: 0.2 + connection.strength * 0.2)
        ..strokeWidth = 1 + connection.strength
        ..style = PaintingStyle.stroke;

      canvas.drawLine(fromPos, toPos, connectionPaint);

      // Flowing particle on connection
      final particlePos = Offset.lerp(fromPos, toPos, flowPosition)!;
      final particlePaint = Paint()
        ..color = Color.lerp(from.color, to.color, flowPosition)!
            .withValues(alpha: 0.8)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

      canvas.drawCircle(particlePos, 2 + connection.strength * 2, particlePaint);
    }

    // Draw nodes
    for (final node in nodes) {
      final pos = Offset(
        center.dx + (node.x - 0.5) * scale,
        center.dy + (node.y - 0.5) * scale,
      );

      // Calculate pulse for this node
      final nodePulse = math.sin(pulseValue * math.pi * 2 + node.pulsePhase);
      final pulseScale = 1.0 + nodePulse * 0.2 * node.activityLevel;
      final currentSize = node.size * pulseScale;

      // Outer glow
      final glowPaint = Paint()
        ..color = node.color.withValues(alpha: 0.3 * node.activityLevel)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, currentSize);
      canvas.drawCircle(pos, currentSize * 1.5, glowPaint);

      // Middle glow
      final midGlowPaint = Paint()
        ..color = node.color.withValues(alpha: 0.5 * node.activityLevel)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, currentSize * 0.5);
      canvas.drawCircle(pos, currentSize, midGlowPaint);

      // Core
      final corePaint = Paint()
        ..color = node.color
        ..style = PaintingStyle.fill;
      canvas.drawCircle(pos, currentSize * 0.5, corePaint);

      // Bright center
      final centerPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.8 + nodePulse * 0.2);
      canvas.drawCircle(pos, currentSize * 0.2, centerPaint);
    }
  }

  @override
  bool shouldRepaint(NeuralMapPainter oldDelegate) {
    return pulseValue != oldDelegate.pulseValue ||
        connectionValue != oldDelegate.connectionValue;
  }
}
