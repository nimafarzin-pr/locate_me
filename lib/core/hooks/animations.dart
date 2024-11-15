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
  double endScale = 0.1,
  Curve curve = Curves.easeInOut,
  Duration duration = const Duration(milliseconds: 800),
}) {
  final animationController = useAnimationController(duration: duration);
  final scaleAnimation = useAnimation(
    Tween<double>(begin: beginScale, end: endScale).animate(
      CurvedAnimation(parent: animationController, curve: curve),
    ),
  );

  useEffect(() {
    animationController.forward();
    return null;
  }, []);

  return scaleAnimation;
}

Animation<double> useTransformAnimation({
  double startAngle = 0.0,
  double endAngle = 360.0,
  Curve curve = Curves.easeInOut,
  Duration duration = const Duration(milliseconds: 2000),
}) {
  // Set up the animation controller
  final animationController = useAnimationController(duration: duration);
  final animation = Tween<double>(begin: startAngle, end: endAngle).animate(
    CurvedAnimation(parent: animationController, curve: curve),
  );

  useEffect(() {
    animationController.forward();
    return null;
  }, []);

  return animation;
}
