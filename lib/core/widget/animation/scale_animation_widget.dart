import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScaleAnimationWidget extends HookWidget {
  final Widget child;
  final Duration duration;
  final double startScale;
  final double endScale;
  final Curve curve;

  const ScaleAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.startScale = 0.1,
    this.endScale = 1.0,
    this.curve = Curves.easeOut,
  });

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: duration);
    final animation = Tween<double>(begin: startScale, end: endScale).animate(
      CurvedAnimation(parent: animationController, curve: curve),
    );

    useEffect(() {
      animationController.forward();
      return null;
    }, []);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          child: child,
        );
      },
      child: child,
    );
  }
}
