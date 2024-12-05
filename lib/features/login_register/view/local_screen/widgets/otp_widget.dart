import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/sizing/my_text_size.dart';

class SquareOtpField extends StatelessWidget {
  final TextEditingController controller;
  final int length;
  final bool obscureText;
  final void Function(String)? onCompleted;
  final String? Function(String?)? validator;

  const SquareOtpField({
    super.key,
    required this.controller,
    this.length = 4,
    this.obscureText = false,
    this.onCompleted,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(fontSize: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Pinput(
          onSubmitted: validator,
          errorTextStyle: TextStyle(
              fontSize: AppTextFontsAndSizing.bodySmallFontSize,
              color: Theme.of(context).colorScheme.error),
          validator: validator,
          controller: controller,
          length: length,
          obscureText: obscureText,
          defaultPinTheme: defaultPinTheme,
          onCompleted: onCompleted,
        ),
      ),
    );
  }
}
