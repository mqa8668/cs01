import 'package:flutter/material.dart';

/// App color palette inspired by pastel/cosmic neural network aesthetic
class AppColors {
  AppColors._();

  // ============================================
  // LIGHT MODE (Pastel)
  // ============================================
  static const light = _LightColors();

  // ============================================
  // DARK MODE (Cosmic)
  // ============================================
  static const dark = _DarkColors();

  // ============================================
  // SHARED GRADIENTS
  // ============================================
  static const List<Color> neuralGradientLight = [
    Color(0xFF8FE8E8), // Cyan
    Color(0xFFE0D4F7), // Lavender
    Color(0xFFF5B8C8), // Pink
  ];

  static const List<Color> neuralGradientDark = [
    Color(0xFF00D4FF), // Bright cyan
    Color(0xFFAA80FF), // Purple
    Color(0xFFFF69B4), // Pink/Magenta
  ];

  static const List<Color> backgroundGradientLight = [
    Color(0xFFFFFBFF), // Almost white
    Color(0xFFF8F4FF), // Soft lavender tint
    Color(0xFFFFF5F8), // Soft pink tint
  ];

  static const List<Color> backgroundGradientDark = [
    Color(0xFF0D0B1E), // Deep space
    Color(0xFF1A1530), // Dark purple
    Color(0xFF0F1A2E), // Dark blue
  ];
}

class _LightColors {
  const _LightColors();

  // Primary colors
  Color get primary => const Color(0xFF7B68EE);
  Color get primaryContainer => const Color(0xFFE8E0FF);
  Color get onPrimary => const Color(0xFFFFFFFF);
  Color get onPrimaryContainer => const Color(0xFF21005D);

  // Secondary colors
  Color get secondary => const Color(0xFF8FE8E8);
  Color get secondaryContainer => const Color(0xFFD4F4F4);
  Color get onSecondary => const Color(0xFF003737);
  Color get onSecondaryContainer => const Color(0xFF002020);

  // Tertiary colors
  Color get tertiary => const Color(0xFFF5B8C8);
  Color get tertiaryContainer => const Color(0xFFFFE4EA);
  Color get onTertiary => const Color(0xFF4A1520);
  Color get onTertiaryContainer => const Color(0xFF31101A);

  // Background & Surface
  Color get background => const Color(0xFFFFFBFF);
  Color get surface => const Color(0xFFFFFBFF);
  Color get surfaceVariant => const Color(0xFFF3EDF7);
  Color get onBackground => const Color(0xFF1C1B1F);
  Color get onSurface => const Color(0xFF1C1B1F);
  Color get onSurfaceVariant => const Color(0xFF49454F);

  // Neural network specific
  Color get neuralCyan => const Color(0xFF8FE8E8);
  Color get neuralPink => const Color(0xFFF5B8C8);
  Color get neuralLavender => const Color(0xFFE0D4F7);
  Color get nodeGlow => const Color(0xFFFFFFFF);
  Color get connectionLine => const Color(0xFFD0C8E8);

  // Accents
  Color get accentCoral => const Color(0xFFFFB5A7);
  Color get accentSky => const Color(0xFF9ED8E8);
  Color get accentMint => const Color(0xFFA8E6CF);

  // Semantic colors
  Color get success => const Color(0xFF4CAF50);
  Color get error => const Color(0xFFE57373);
  Color get warning => const Color(0xFFFFB74D);
  Color get info => const Color(0xFF64B5F6);

  // Card & Container
  Color get cardBackground => const Color(0xFFFFFFFF);
  Color get cardBorder => const Color(0xFFE8E0F0);
  Color get shadowColor => const Color(0x1A7B68EE);

  // Text
  Color get textPrimary => const Color(0xFF1C1B1F);
  Color get textSecondary => const Color(0xFF49454F);
  Color get textHint => const Color(0xFF79747E);
}

class _DarkColors {
  const _DarkColors();

  // Primary colors
  Color get primary => const Color(0xFFAA80FF);
  Color get primaryContainer => const Color(0xFF4A2C7A);
  Color get onPrimary => const Color(0xFF21005D);
  Color get onPrimaryContainer => const Color(0xFFE8DDFF);

  // Secondary colors
  Color get secondary => const Color(0xFF00D4FF);
  Color get secondaryContainer => const Color(0xFF004D5E);
  Color get onSecondary => const Color(0xFF003544);
  Color get onSecondaryContainer => const Color(0xFFB8EAFF);

  // Tertiary colors
  Color get tertiary => const Color(0xFFFF69B4);
  Color get tertiaryContainer => const Color(0xFF5D2C4A);
  Color get onTertiary => const Color(0xFF5D1049);
  Color get onTertiaryContainer => const Color(0xFFFFD9E9);

  // Background & Surface
  Color get background => const Color(0xFF0D0B1E);
  Color get surface => const Color(0xFF141226);
  Color get surfaceVariant => const Color(0xFF1E1A32);
  Color get onBackground => const Color(0xFFE6E1E5);
  Color get onSurface => const Color(0xFFE6E1E5);
  Color get onSurfaceVariant => const Color(0xFFCAC4D0);

  // Neural network specific
  Color get neuralCyan => const Color(0xFF00D4FF);
  Color get neuralPink => const Color(0xFFFF69B4);
  Color get neuralPurple => const Color(0xFFAA80FF);
  Color get nodeGlow => const Color(0xFFE8E4FF);
  Color get connectionLine => const Color(0xFF6B5B95);
  Color get starGlow => const Color(0xFFE8E4FF);

  // Cosmic specific
  Color get cosmicDeep => const Color(0xFF0D0B1E);
  Color get cosmicPurple => const Color(0xFF4A2C7A);
  Color get cosmicBlue => const Color(0xFF1E3A5F);
  Color get nebulaGlow => const Color(0x4000D4FF);

  // Semantic colors
  Color get success => const Color(0xFF81C784);
  Color get error => const Color(0xFFFF8A80);
  Color get warning => const Color(0xFFFFD54F);
  Color get info => const Color(0xFF81D4FA);

  // Card & Container
  Color get cardBackground => const Color(0xFF1A1830);
  Color get cardBorder => const Color(0xFF2D2850);
  Color get shadowColor => const Color(0x4000D4FF);
  Color get glassBackground => const Color(0x1AFFFFFF);

  // Text
  Color get textPrimary => const Color(0xFFE6E1E5);
  Color get textSecondary => const Color(0xFFCAC4D0);
  Color get textHint => const Color(0xFF938F99);
}
