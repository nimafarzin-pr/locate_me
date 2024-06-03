import 'package:flutter/material.dart';

import '../../ivalidator.dart';

class SerialTypeCheck implements IInputValidator {
  final String errorMessage;

  SerialTypeCheck({required this.errorMessage});

  @override
  bool isValid(BuildContext context, String? value) =>
      (value!.contains('W') || value.contains('w'));
  @override
  String message(BuildContext context) {
    return errorMessage;
  }
}
