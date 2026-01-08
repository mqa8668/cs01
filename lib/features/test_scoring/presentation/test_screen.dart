import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';

/// Production-grade Test & Score screen with mock assessment data
class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> with TickerProviderStateMixin {
  late AnimationController _cardController;
  late AnimationController _progressController;
  late AnimationController _shimmerController;

  // Mock test data
  final List<AssessmentTest> _tests = [
    AssessmentTest(
      id: '1',
      name: 'Anxiety Assessment',
      description: 'GAD-7 standardized questionnaire',
      icon: Icons.psychology,
      color: const Color(0xFF00D4FF),
      questionCount: 7,
      completedCount: 7,
      lastScore: 8,
      maxScore: 21,
      trend: -2,
      lastTaken: DateTime.now().subtract(const Duration(days: 2)),
    ),
    AssessmentTest(
      id: '2',
      name: 'Depression Screening',
      description: 'PHQ-9 clinical assessment',
      icon: Icons.favorite_border,
      color: const Color(0xFFFF69B4),
      questionCount: 9,
      completedCount: 9,
      lastScore: 5,
      maxScore: 27,
      trend: -3,
      lastTaken: DateTime.now().subtract(const Duration(days: 5)),
    ),
    AssessmentTest(
      id: '3',
      name: 'Stress Level Check',
      description: 'PSS-10 perceived stress scale',
      icon: Icons.bolt,
      color: const Color(0xFFFFB347),
      questionCount: 10,
      completedCount: 6,
      lastScore: null,
      maxScore: 40,
      trend: 0,
      lastTaken: null,
    ),
    AssessmentTest(
      id: '4',
      name: 'Sleep Quality',
      description: 'PSQI sleep assessment',
      icon: Icons.bedtime,
      color: const Color(0xFFAA80FF),
      questionCount: 19,
      completedCount: 19,
      lastScore: 6,
      maxScore: 21,
      trend: 1,
      lastTaken: DateTime.now().subtract(const Duration(days: 7)),
    ),
    AssessmentTest(
      id: '5',
      name: 'Mindfulness Index',
      description: 'MAAS awareness scale',
      icon: Icons.self_improvement,
      color: const Color(0xFF4ECDC4),
      questionCount: 15,
      completedCount: 0,
      lastScore: null,
      maxScore: 90,
      trend: 0,
      lastTaken: null,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _cardController.dispose();
    _progressController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        text: 'Test & Score',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_tests.where((t) => t.lastScore != null).length} of ${_tests.length} completed',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppColors.dark.textSecondary
                              : AppColors.light.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  _buildOverallScore(isDark),
                ],
              ),
            ),

            // Test List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _tests.length,
                itemBuilder: (context, index) {
                  return _buildTestCard(_tests[index], index, isDark);
                },
              ),
            ),

            // Bottom Summary
            _buildSummaryPanel(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallScore(bool isDark) {
    final completedTests = _tests.where((t) => t.lastScore != null).toList();
    final avgScore = completedTests.isEmpty
        ? 0.0
        : completedTests.map((t) => t.lastScore! / t.maxScore * 100).reduce((a, b) => a + b) /
            completedTests.length;

    return AnimatedBuilder(
      animation: _progressController,
      builder: (context, child) {
        return Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              startAngle: -math.pi / 2,
              endAngle: math.pi * 1.5,
              colors: [
                AppColors.dark.neuralCyan,
                AppColors.dark.neuralPink,
                AppColors.dark.neuralPurple,
                AppColors.dark.neuralCyan,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.dark.neuralCyan.withValues(alpha: 0.3),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? AppColors.dark.cardBackground : AppColors.light.cardBackground,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${(avgScore * _progressController.value).toInt()}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Score',
                    style: TextStyle(
                      fontSize: 10,
                      color: isDark
                          ? AppColors.dark.textSecondary
                          : AppColors.light.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTestCard(AssessmentTest test, int index, bool isDark) {
    final isCompleted = test.lastScore != null;
    final progress = test.completedCount / test.questionCount;

    return AnimatedBuilder(
      animation: _cardController,
      builder: (context, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _cardController,
          curve: Interval(
            index * 0.1,
            0.5 + index * 0.1,
            curve: Curves.easeOutCubic,
          ),
        ));

        final fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _cardController,
            curve: Interval(index * 0.1, 0.5 + index * 0.1),
          ),
        );

        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.dark.cardBackground
                    : AppColors.light.cardBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isCompleted
                      ? test.color.withValues(alpha: 0.3)
                      : (isDark ? AppColors.dark.cardBorder : AppColors.light.cardBorder),
                ),
                boxShadow: isCompleted
                    ? [
                        BoxShadow(
                          color: test.color.withValues(alpha: 0.15),
                          blurRadius: 15,
                          spreadRadius: 0,
                        ),
                      ]
                    : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Icon
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: test.color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: test.color.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Icon(
                            test.icon,
                            color: test.color,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      test.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  if (test.trend != 0)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: test.trend < 0
                                            ? Colors.green.withValues(alpha: 0.2)
                                            : Colors.orange.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            test.trend < 0
                                                ? Icons.trending_down
                                                : Icons.trending_up,
                                            size: 14,
                                            color: test.trend < 0
                                                ? Colors.green
                                                : Colors.orange,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${test.trend.abs()}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: test.trend < 0
                                                  ? Colors.green
                                                  : Colors.orange,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                test.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark
                                      ? AppColors.dark.textSecondary
                                      : AppColors.light.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Progress bar
                              Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: AnimatedBuilder(
                                        animation: _progressController,
                                        builder: (context, child) {
                                          return LinearProgressIndicator(
                                            value: progress * _progressController.value,
                                            backgroundColor: test.color.withValues(alpha: 0.1),
                                            valueColor: AlwaysStoppedAnimation(test.color),
                                            minHeight: 6,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  if (isCompleted)
                                    Text(
                                      '${test.lastScore}/${test.maxScore}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: test.color,
                                      ),
                                    )
                                  else
                                    Text(
                                      '${test.completedCount}/${test.questionCount}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isDark
                                            ? AppColors.dark.textSecondary
                                            : AppColors.light.textSecondary,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 8),
                        Icon(
                          Icons.chevron_right,
                          color: isDark
                              ? AppColors.dark.textSecondary
                              : AppColors.light.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryPanel(bool isDark) {
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
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryStat(
            'Completed',
            '${_tests.where((t) => t.lastScore != null).length}',
            Icons.check_circle,
            Colors.green,
          ),
          _buildSummaryStat(
            'In Progress',
            '${_tests.where((t) => t.completedCount > 0 && t.lastScore == null).length}',
            Icons.pending,
            Colors.orange,
          ),
          _buildSummaryStat(
            'Not Started',
            '${_tests.where((t) => t.completedCount == 0).length}',
            Icons.radio_button_unchecked,
            AppColors.dark.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStat(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
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

class AssessmentTest {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final int questionCount;
  final int completedCount;
  final int? lastScore;
  final int maxScore;
  final int trend;
  final DateTime? lastTaken;

  AssessmentTest({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.questionCount,
    required this.completedCount,
    this.lastScore,
    required this.maxScore,
    required this.trend,
    this.lastTaken,
  });
}
