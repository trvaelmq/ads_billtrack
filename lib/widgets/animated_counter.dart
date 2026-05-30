import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  final double value;
  final TextStyle? style;
  final String prefix;
  final int decimalPlaces;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.prefix = '¥',
    this.decimalPlaces = 2,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutExpo,
      builder: (context, val, _) {
        return Text(
          '$prefix${val.toStringAsFixed(decimalPlaces)}',
          style: style,
        );
      },
    );
  }
}
