import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:locate_me/core/hooks/animations.dart';

class TransformAnimationWidget extends HookWidget {
  final Widget child;
  final Duration duration;
  final double startAngle;
  final double endAngle;
  final Curve curve;

  const TransformAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.startAngle = 0.0,
    this.endAngle = 360.0,
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    final animation = useTransformAnimation(
        curve: curve,
        duration: duration,
        endAngle: endAngle,
        startAngle: startAngle);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: animation.value *
              (3.1415926535 / 180), // Convert degrees to radians
          child: child,
        );
      },
      child: child,
    );
  }
}
