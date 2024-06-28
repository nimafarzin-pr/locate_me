import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../hooks/animations.dart';

class FadeInScaleAnimation extends HookWidget {
  const FadeInScaleAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.beginScale = 0.8,
  });

  final Widget child;
  final Duration duration;
  final double beginScale;

  @override
  Widget build(BuildContext context) {
    final fade = useFadeAnimation(duration: duration);
    final scaleAnimation = useScaleAnimation(
      beginScale: beginScale,
      duration: duration,
    );

    return Opacity(
      opacity: fade,
      child: Transform.scale(
        scale: scaleAnimation,
        child: child,
      ),
    );
  }
}
