import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';

/// Production-grade Mini Diary with entries and mood tracking
class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late ScrollController _scrollController;

  // Mock diary entries
  final List<DiaryEntry> _entries = [
    DiaryEntry(
      id: '1',
      date: DateTime.now(),
      title: 'Finding Inner Peace',
      content: 'Today I practiced mindfulness for 20 minutes. The neural map showed increased activity in my prefrontal cortex. Feeling more centered and focused.',
      mood: Mood.great,
      tags: ['mindfulness', 'meditation', 'focus'],
      wordCount: 156,
    ),
    DiaryEntry(
      id: '2',
      date: DateTime.now().subtract(const Duration(days: 1)),
      title: 'Challenging Day',
      content: 'Work was stressful but I managed to take breaks and use breathing exercises. The garden grew a new flower today - a gratitude rose.',
      mood: Mood.okay,
      tags: ['work', 'stress', 'breathing'],
      wordCount: 89,
    ),
    DiaryEntry(
      id: '3',
      date: DateTime.now().subtract(const Duration(days: 2)),
      title: 'Morning Reflection',
      content: 'Woke up feeling refreshed. Completed my anxiety assessment - score improved by 2 points! Small wins matter.',
      mood: Mood.good,
      tags: ['morning', 'progress', 'assessment'],
      wordCount: 67,
    ),
    DiaryEntry(
      id: '4',
      date: DateTime.now().subtract(const Duration(days: 3)),
      title: 'Gratitude Practice',
      content: 'Listed 5 things I\'m grateful for today. My garden is thriving with 15 bloomed flowers. Feeling connected to my wellness journey.',
      mood: Mood.great,
      tags: ['gratitude', 'garden', 'wellness'],
      wordCount: 112,
    ),
    DiaryEntry(
      id: '5',
      date: DateTime.now().subtract(const Duration(days: 5)),
      title: 'Rest Day',
      content: 'Took the day to rest and recharge. Sometimes doing nothing is the most productive thing. Neural pathways need recovery time too.',
      mood: Mood.good,
      tags: ['rest', 'recovery', 'selfcare'],
      wordCount: 78,
    ),
    DiaryEntry(
      id: '6',
      date: DateTime.now().subtract(const Duration(days: 7)),
      title: 'Weekly Review',
      content: 'Reviewed my progress this week. 5 meditation sessions completed, 3 assessments taken, garden health at 65%. Proud of my consistency.',
      mood: Mood.great,
      tags: ['review', 'progress', 'consistency'],
      wordCount: 134,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    _scrollController.dispose();
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
                        text: 'Mini Diary',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_entries.length} reflections',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppColors.dark.textSecondary
                              : AppColors.light.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  _buildWriteButton(isDark),
                ],
              ),
            ),

            // Mood Summary
            _buildMoodSummary(isDark),

            // Entries List
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _entries.length,
                itemBuilder: (context, index) {
                  return _buildEntryCard(_entries[index], index, isDark);
                },
              ),
            ),

            // Bottom Stats
            _buildStatsBar(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildWriteButton(bool isDark) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final scale = 1.0 + _pulseController.value * 0.05;
        final glowIntensity = 0.3 + _pulseController.value * 0.3;

        return Transform.scale(
          scale: scale,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.dark.neuralCyan,
                  AppColors.dark.neuralPink,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.dark.neuralCyan.withValues(alpha: glowIntensity),
                  blurRadius: 15,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(16),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Write',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMoodSummary(bool isDark) {
    final moodCounts = <Mood, int>{};
    for (final entry in _entries) {
      moodCounts[entry.mood] = (moodCounts[entry.mood] ?? 0) + 1;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.dark.cardBackground.withValues(alpha: 0.6)
            : AppColors.light.cardBackground.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.dark.cardBorder : AppColors.light.cardBorder,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: Mood.values.map((mood) {
          final count = moodCounts[mood] ?? 0;
          final isActive = count > 0;

          return Column(
            children: [
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  final glowIntensity = isActive ? _pulseController.value * 0.3 : 0.0;

                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: mood.color.withValues(alpha: isActive ? 0.2 : 0.05),
                      shape: BoxShape.circle,
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: mood.color.withValues(alpha: glowIntensity),
                                blurRadius: 10,
                                spreadRadius: 0,
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      mood.emoji,
                      style: TextStyle(
                        fontSize: 20,
                        color: isActive ? null : Colors.grey.withValues(alpha: 0.5),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 4),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isActive
                      ? mood.color
                      : (isDark ? AppColors.dark.textHint : AppColors.light.textHint),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEntryCard(DiaryEntry entry, int index, bool isDark) {
    final isToday = _isToday(entry.date);

    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _fadeController,
          curve: Interval(
            index * 0.08,
            0.5 + index * 0.08,
            curve: Curves.easeOutCubic,
          ),
        ));

        final fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _fadeController,
            curve: Interval(index * 0.08, 0.5 + index * 0.08),
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
                  color: isToday
                      ? entry.mood.color.withValues(alpha: 0.4)
                      : (isDark ? AppColors.dark.cardBorder : AppColors.light.cardBorder),
                  width: isToday ? 2 : 1,
                ),
                boxShadow: isToday
                    ? [
                        BoxShadow(
                          color: entry.mood.color.withValues(alpha: 0.15),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header row
                        Row(
                          children: [
                            // Mood indicator
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: entry.mood.color.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                entry.mood.emoji,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Title and date
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          entry.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      if (isToday)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: entry.mood.color.withValues(alpha: 0.2),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Text(
                                            'Today',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _formatDate(entry.date),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark
                                          ? AppColors.dark.textSecondary
                                          : AppColors.light.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Content preview
                        Text(
                          entry.content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: isDark
                                ? AppColors.dark.textPrimary.withValues(alpha: 0.8)
                                : AppColors.light.textPrimary.withValues(alpha: 0.8),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Tags and word count
                        Row(
                          children: [
                            Expanded(
                              child: Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: entry.tags.take(3).map((tag) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? AppColors.dark.surfaceVariant
                                          : AppColors.light.surfaceVariant,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '#$tag',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: isDark
                                            ? AppColors.dark.textSecondary
                                            : AppColors.light.textSecondary,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Text(
                              '${entry.wordCount} words',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark
                                    ? AppColors.dark.textHint
                                    : AppColors.light.textHint,
                              ),
                            ),
                          ],
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

  Widget _buildStatsBar(bool isDark) {
    final totalWords = _entries.fold<int>(0, (sum, e) => sum + e.wordCount);
    final streakDays = 7; // Mock streak

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
          _buildStatItem(
            Icons.local_fire_department,
            '$streakDays',
            'Day Streak',
            Colors.orange,
          ),
          _buildStatItem(
            Icons.article,
            '${_entries.length}',
            'Entries',
            AppColors.dark.neuralCyan,
          ),
          _buildStatItem(
            Icons.text_fields,
            _formatNumber(totalWords),
            'Words',
            AppColors.dark.neuralPink,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
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

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  String _formatDate(DateTime date) {
    if (_isToday(date)) return 'Today';

    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return 'Yesterday';
    }

    final days = now.difference(date).inDays;
    if (days < 7) return '$days days ago';

    return '${date.month}/${date.day}/${date.year}';
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }
}

enum Mood {
  great('Great', Color(0xFF4ECDC4), ''),
  good('Good', Color(0xFF7FFF7F), ''),
  okay('Okay', Color(0xFFFFD93D), ''),
  low('Low', Color(0xFFFF9F43), ''),
  difficult('Difficult', Color(0xFFFF6B6B), '');

  final String label;
  final Color color;
  final String emoji;

  const Mood(this.label, this.color, this.emoji);
}

class DiaryEntry {
  final String id;
  final DateTime date;
  final String title;
  final String content;
  final Mood mood;
  final List<String> tags;
  final int wordCount;

  DiaryEntry({
    required this.id,
    required this.date,
    required this.title,
    required this.content,
    required this.mood,
    required this.tags,
    required this.wordCount,
  });
}
