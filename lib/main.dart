import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: NeuralMapApp(),
    ),
  );
}

class NeuralMapApp extends ConsumerWidget {
  const NeuralMapApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Neural Map',
      debugShowCheckedModeBanner: false,

      // Theme configuration
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,

      // Router configuration
      routerConfig: appRouter,
    );
  }
}
