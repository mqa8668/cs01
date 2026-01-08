import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';

/// Main shell with bottom navigation
class HomeShell extends ConsumerWidget {
  final Widget child;

  const HomeShell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBackground = isDark
        ? AppColors.dark.cardBackground
        : AppColors.light.cardBackground;
    final cardBorder =
        isDark ? AppColors.dark.cardBorder : AppColors.light.cardBorder;

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: cardBackground.withValues(alpha: 0.95),
          border: Border(
            top: BorderSide(
              color: cardBorder,
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.psychology_outlined,
                  activeIcon: Icons.psychology,
                  label: 'Neural',
                  route: Routes.neuralMap,
                ),
                _NavItem(
                  icon: Icons.quiz_outlined,
                  activeIcon: Icons.quiz,
                  label: 'Test',
                  route: Routes.testScoring,
                ),
                _NavItem(
                  icon: Icons.local_florist_outlined,
                  activeIcon: Icons.local_florist,
                  label: 'Garden',
                  route: Routes.mindGarden,
                ),
                _NavItem(
                  icon: Icons.book_outlined,
                  activeIcon: Icons.book,
                  label: 'Diary',
                  route: Routes.miniDiary,
                ),
                _NavItem(
                  icon: Icons.water_drop_outlined,
                  activeIcon: Icons.water_drop,
                  label: 'Care',
                  route: Routes.careDrops,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.path;
    final isActive = currentRoute == route;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final primaryContainer = isDark
        ? AppColors.dark.primaryContainer
        : AppColors.light.primaryContainer;
    final primary = isDark ? AppColors.dark.primary : AppColors.light.primary;
    final textHint =
        isDark ? AppColors.dark.textHint : AppColors.light.textHint;

    return GestureDetector(
      onTap: () => context.go(route),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? primaryContainer.withValues(alpha: 0.5)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? primary : textHint,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? primary : textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
