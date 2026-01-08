import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Text widget with gradient fill
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final List<Color>? colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final TextAlign? textAlign;

  const GradientText({
    super.key,
    required this.text,
    this.style,
    this.colors,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColors = colors ??
        (isDark ? AppColors.neuralGradientDark : AppColors.neuralGradientLight);

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        begin: begin,
        end: end,
        colors: effectiveColors,
      ).createShader(bounds),
      child: Text(
        text,
        style: style ?? Theme.of(context).textTheme.headlineMedium,
        textAlign: textAlign,
      ),
    );
  }
}
