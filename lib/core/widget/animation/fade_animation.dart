import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../hooks/animations.dart';

class FadeAnimationWidget extends HookWidget {
  const FadeAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  });

  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final fade = useFadeAnimation(duration: duration);
    return Opacity(
      opacity: fade,
      child: child,
    );
  }
}
