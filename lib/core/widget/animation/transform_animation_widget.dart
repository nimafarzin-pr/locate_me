import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
    // Set up the animation controller
    final animationController = useAnimationController(duration: duration);
    final animation = Tween<double>(begin: startAngle, end: endAngle).animate(
      CurvedAnimation(parent: animationController, curve: curve),
    );

    useEffect(() {
      animationController.forward();
      return null;
    }, []);

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
