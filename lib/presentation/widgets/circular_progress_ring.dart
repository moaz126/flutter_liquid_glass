import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class CircularProgressRing extends CustomPainter {
  final double movePercent;
  final double exercisePercent;
  final double standPercent;
  final double strokeWidth;

  CircularProgressRing({
    required this.movePercent,
    required this.exercisePercent,
    required this.standPercent,
    this.strokeWidth = 14.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    
    // Spacing between rings
    const spacing = 4.0;
    
    // Radii for each ring
    final moveRadius = radius - (strokeWidth / 2);
    final exerciseRadius = moveRadius - strokeWidth - spacing;
    final standRadius = exerciseRadius - strokeWidth - spacing;

    // Draw backgrounds
    _drawRingBg(canvas, center, moveRadius, AppTheme.primary.withOpacity(0.15));
    _drawRingBg(canvas, center, exerciseRadius, AppTheme.accent.withOpacity(0.15));
    _drawRingBg(canvas, center, standRadius, AppTheme.success.withOpacity(0.15));

    // Draw foregrounds (progress)
    _drawRingFg(canvas, center, moveRadius, AppTheme.primary, movePercent);
    _drawRingFg(canvas, center, exerciseRadius, AppTheme.accent, exercisePercent);
    _drawRingFg(canvas, center, standRadius, AppTheme.success, standPercent);
  }

  void _drawRingBg(Canvas canvas, Offset center, double radius, Color color) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, paint);
  }

  void _drawRingFg(Canvas canvas, Offset center, double radius, Color color, double percent) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Start from top (-pi / 2), draw clockwise
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * percent.clamp(0.0, 1.0),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CircularProgressRing oldDelegate) {
    return oldDelegate.movePercent != movePercent ||
        oldDelegate.exercisePercent != exercisePercent ||
        oldDelegate.standPercent != standPercent ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
