// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyLoading extends StatelessWidget {
  final double size;
  const MyLoading({
    super.key,
    this.size = 50,
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
                    color: Theme.of(context).colorScheme.primary))),
      ],
    );
  }
}
