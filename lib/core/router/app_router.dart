import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/home_shell.dart';
import '../../features/neural_map/presentation/neural_map_screen.dart';
import '../../features/test_scoring/presentation/test_screen.dart';
import '../../features/mind_garden/presentation/garden_screen.dart';
import '../../features/mini_diary/presentation/diary_screen.dart';
import '../../features/care_drops/presentation/care_drops_screen.dart';
import 'routes.dart';

/// Global navigation key
final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

/// App router configuration
final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.neuralMap,
  routes: [
    // Shell route with bottom navigation
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return HomeShell(child: child);
      },
      routes: [
        // Neural Map
        GoRoute(
          path: Routes.neuralMap,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: NeuralMapScreen(),
          ),
        ),

        // Test & Scoring
        GoRoute(
          path: Routes.testScoring,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: TestScreen(),
          ),
        ),

        // Mind Garden
        GoRoute(
          path: Routes.mindGarden,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: GardenScreen(),
          ),
        ),

        // Mini Diary
        GoRoute(
          path: Routes.miniDiary,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: DiaryScreen(),
          ),
        ),

        // Care Drops
        GoRoute(
          path: Routes.careDrops,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: CareDropsScreen(),
          ),
        ),
      ],
    ),
  ],
);
