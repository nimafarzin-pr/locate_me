// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyLoading extends StatelessWidget {
  final double size;
  final Color? color;
  const MyLoading({
    super.key,
    this.size = 50,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                    strokeWidth: 0.8,
                    color: color ?? Theme.of(context).colorScheme.primary))),
      ],
    );
  }
}
