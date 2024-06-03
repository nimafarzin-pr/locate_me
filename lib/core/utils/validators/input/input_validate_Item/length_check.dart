import 'package:flutter/material.dart';

import '../../ivalidator.dart';

class LengthCheck implements IInputValidator {
  final int length;
  final String errorMessage;

  LengthCheck({required this.length, required this.errorMessage});

  @override
  bool isValid(BuildContext context, String? value) =>
      value!.length < length ? false : true;

  @override
  String message(BuildContext context) {
    return errorMessage;
  }
}
