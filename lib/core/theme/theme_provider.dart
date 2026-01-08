import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Theme mode options
enum AppThemeMode {
  light,
  dark,
  system,
}

/// Theme state
class ThemeState {
  final AppThemeMode mode;
  final bool useCosmicAnimations;

  const ThemeState({
    this.mode = AppThemeMode.system,
    this.useCosmicAnimations = true,
  });

  ThemeState copyWith({
    AppThemeMode? mode,
    bool? useCosmicAnimations,
  }) {
    return ThemeState(
      mode: mode ?? this.mode,
      useCosmicAnimations: useCosmicAnimations ?? this.useCosmicAnimations,
    );
  }

  /// Get the actual ThemeMode for MaterialApp
  ThemeMode get themeMode {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}

/// Theme state notifier
class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(const ThemeState());

  /// Set theme mode
  void setThemeMode(AppThemeMode mode) {
    state = state.copyWith(mode: mode);
  }

  /// Toggle between light and dark (ignoring system)
  void toggleTheme() {
    final newMode = state.mode == AppThemeMode.dark
        ? AppThemeMode.light
        : AppThemeMode.dark;
    state = state.copyWith(mode: newMode);
  }

  /// Set cosmic animations preference
  void setCosmicAnimations(bool enabled) {
    state = state.copyWith(useCosmicAnimations: enabled);
  }
}

/// Theme provider
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

/// Convenience provider to check if dark mode is active
final isDarkModeProvider = Provider<bool>((ref) {
  final themeState = ref.watch(themeProvider);
  // This is a simplification - in real app you'd check system brightness
  return themeState.mode == AppThemeMode.dark;
});

/// Provider for ThemeMode to use in MaterialApp
final themeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(themeProvider).themeMode;
});
