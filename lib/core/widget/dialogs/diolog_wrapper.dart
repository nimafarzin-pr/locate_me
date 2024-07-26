// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:locate_me/core/extension/screen_size_extension.dart';

class DialogWrapper extends StatelessWidget {
  final Widget child;
  final double? height;
  const DialogWrapper({
    super.key,
    required this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: context.screenWidth / 1.1,
                height: height ?? context.screenWidth / 1.1,
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: SingleChildScrollView(child: child),
              ),
            ),
          ],
        ));
  }
}
