import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

double useFadeAnimation({
  Curve curve = Curves.easeInOut,
  Duration duration = const Duration(milliseconds: 800),
}) {
  final animationController = useAnimationController(duration: duration);
  final fadeAnimation = useAnimation(
    CurvedAnimation(parent: animationController, curve: curve),
  );

  useEffect(() {
    animationController.forward();
    return null;
  }, []);

  return fadeAnimation;
}

double useScaleAnimation({
  double beginScale = 0.8,
  Curve curve = Curves.easeInOut,
  Duration duration = const Duration(milliseconds: 800),
}) {
  final animationController = useAnimationController(duration: duration);
  final scaleAnimation = useAnimation(
    Tween<double>(begin: beginScale, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: curve),
    ),
  );

  useEffect(() {
    animationController.forward();
    return null;
  }, []);

  return scaleAnimation;
}
