import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class FitnessCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final double borderRadius;
  final bool animatedHover;
  final double? width;
  final double? height;

  const FitnessCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(20),
    this.color,
    this.borderRadius = 20.0,
    this.animatedHover = true,
    this.width,
    this.height,
  });

  @override
  State<FitnessCard> createState() => _FitnessCardState();
}

class _FitnessCardState extends State<FitnessCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Widget card = AnimatedScale(
      scale: _isPressed && widget.animatedHover ? 0.97 : 1.0,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.color ?? theme.cardTheme.color,
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
            splashColor: AppTheme.primary.withValues(alpha: 0.1),
            highlightColor: Colors.transparent,
            child: Padding(
              padding: widget.padding,
              child: widget.child,
            ),
          ),
        ),
      ),
    );

    return card;
  }
}
