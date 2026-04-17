import 'package:flutter/material.dart';

class CountUpText extends StatefulWidget {
  final double begin;
  final double end;
  final Duration duration;
  final String Function(double value) textBuilder;
  final TextStyle? style;

  const CountUpText({
    super.key,
    required this.begin,
    required this.end,
    this.duration = const Duration(milliseconds: 800),
    required this.textBuilder,
    this.style,
  });

  @override
  State<CountUpText> createState() => _CountUpTextState();
}

class _CountUpTextState extends State<CountUpText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(
      begin: widget.begin,
      end: widget.end,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    )..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant CountUpText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.end != widget.end || oldWidget.begin != widget.begin) {
      _animation = Tween<double>(
        begin: widget.begin,
        end: widget.end,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOut,
        ),
      );
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.textBuilder(_animation.value),
      style: widget.style,
    );
  }
}
