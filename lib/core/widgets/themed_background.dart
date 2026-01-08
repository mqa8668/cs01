import 'package:flutter/material.dart';
import 'cosmic_background.dart';
import 'pastel_background.dart';

/// Automatically selects cosmic or pastel background based on theme
class ThemedBackground extends StatelessWidget {
  final Widget child;
  final bool animate;

  const ThemedBackground({
    super.key,
    required this.child,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      return CosmicBackground(
        animate: animate,
        child: child,
      );
    } else {
      return PastelBackground(
        child: child,
      );
    }
  }
}
