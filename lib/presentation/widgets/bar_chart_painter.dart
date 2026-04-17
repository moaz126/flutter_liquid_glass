import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class BarChartPainter extends CustomPainter {
  final List<double> percentages;
  final double animationValue;

  BarChartPainter({
    required this.percentages,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (percentages.isEmpty) return;

    final barCount = percentages.length;
    final totalSpacing = size.width * 0.4; // 40% of width for spacing
    final barWidth = (size.width - totalSpacing) / barCount;
    final spacing = totalSpacing / (barCount - 1);

    final todayIndex = DateTime.now().weekday - 1; // 0 for Mon, 6 for Sun

    for (int i = 0; i < barCount; i++) {
      final isToday = i == todayIndex;
      final targetPercent = percentages[i];
      // Animate from bottom
      final currentHeight = (size.height * targetPercent) * animationValue;
      
      final xOffset = i * (barWidth + spacing);
      final yOffset = size.height - currentHeight;

      final currentBarWidth = isToday ? barWidth * 1.15 : barWidth;
      final actualXOffset = isToday ? xOffset - (barWidth * 0.075) : xOffset;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(actualXOffset, yOffset, currentBarWidth, currentHeight),
        const Radius.circular(6),
      );

      final paint = Paint()
        ..style = PaintingStyle.fill;

      if (isToday) {
        paint.shader = LinearGradient(
          colors: [
            AppTheme.primary,
            AppTheme.primary.withOpacity(0.6),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(rect.outerRect);
      } else {
        paint.color = AppTheme.primary.withOpacity(0.3);
      }

      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant BarChartPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
           oldDelegate.percentages != percentages;
  }
}
