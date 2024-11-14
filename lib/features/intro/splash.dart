import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';

import 'package:locate_me/core/navigation/routes.dart';
import 'package:locate_me/core/widget/animation/scale_animation_widget.dart';
import 'package:locate_me/core/widget/animation/transform_animation_widget.dart';
import 'package:locate_me/core/widget/custom_text.dart';

import '../../../../../core/resources/icons.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() {
    Future.delayed(const Duration(seconds: 3), () async {
      context.go(
        Routes.root,
      );
    });
    // // Wait for 3 seconds and then navigate to the login screen
    // Timer(const Duration(seconds: 3), () {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).colorScheme.surface, // Customize background color
      body: Center(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Logo placeholder
                ScaleAnimationWidget(
                  duration: const Duration(seconds: 3),
                  startScale: 0.1, // Starts from a very small size
                  endScale: MediaQuery.of(context).size.height /
                      MediaQuery.of(context).size.width /
                      0.4, // Scales to full screen width
                  curve: Curves.easeOut,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const SizedBox(height: 120),
                  TransformAnimationWidget(
                    duration: const Duration(seconds: 3),
                    startAngle: 0.0,
                    endAngle: 360.0,
                    curve: Curves.easeInOut,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(MyIcons.logo), fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomText.bodyLarge('Version 1.0.0'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
