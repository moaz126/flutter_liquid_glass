import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class GradientCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Gradient gradient;
  final double borderRadius;
  final double? width;
  final double? height;

  const GradientCard({
    super.key,
    required this.child,
    required this.gradient,
    this.onTap,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = 24.0,
    this.width,
    this.height,
  });

  @override
  State<GradientCard> createState() => _GradientCardState();
}

class _GradientCardState extends State<GradientCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isPressed ? 0.97 : 1.0,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          gradient: widget.gradient,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: AppTheme.softShadow,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: InkWell(
            onTap: widget.onTap,
            onHighlightChanged: (isHighlighted) {
              setState(() {
                _isPressed = isHighlighted;
              });
            },
            borderRadius: BorderRadius.circular(widget.borderRadius),
            splashColor: Colors.white.withOpacity(0.2),
            highlightColor: Colors.transparent,
            child: Padding(
              padding: widget.padding,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
