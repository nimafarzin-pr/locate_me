// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ColorAnimationWidget extends HookWidget {
  final Widget child;
  final Color activeColor;
  final Color inactiveColor;
  final Duration duration;
  final bool trigger;
  final BoxDecoration? decoration;

  const ColorAnimationWidget({
    super.key,
    required this.child,
    required this.activeColor,
    required this.inactiveColor,
    this.duration = const Duration(milliseconds: 300),
    required this.trigger,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final colorController = useAnimationController(duration: duration);
    final colorAnimation = ColorTween(
      begin: inactiveColor,
      end: activeColor,
    ).animate(colorController);

    // Trigger the animation when the trigger changes
    useEffect(() {
      if (trigger) {
        colorController.forward();
      } else {
        colorController.reverse();
      }
      return null;
    }, [trigger]);

    return AnimatedBuilder(
      animation: colorAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          color: decoration == null ? colorAnimation.value : null,
          decoration: BoxDecoration(
              color: colorAnimation.value,
              borderRadius: decoration?.borderRadius),
          child: child,
        );
      },
      child: child,
    );
  }
}
