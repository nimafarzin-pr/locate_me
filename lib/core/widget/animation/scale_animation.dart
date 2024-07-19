import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:locate_me/core/hooks/animations.dart';

class ScaleAnimationWidget extends HookWidget {
  const ScaleAnimationWidget({
    super.key,
    this.beginScale = 0.8,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  });
  final double beginScale;
  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final scaleAnimation = useScaleAnimation(
      beginScale: beginScale,
      duration: duration,
    );

    return Transform.scale(
      scale: scaleAnimation,
      child: child,
    );
  }
}
