// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:locate_me/core/widget/animation/fade_animation.dart';
import 'package:locate_me/core/widget/animation/scale_animation_widget.dart';

class FadeInScaleAnimation extends HookWidget {
  const FadeInScaleAnimation({
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
    return FadeAnimationWidget(
      child: ScaleAnimationWidget(child: child),
    );
  }
}
