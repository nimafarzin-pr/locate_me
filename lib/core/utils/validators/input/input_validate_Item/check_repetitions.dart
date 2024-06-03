import 'package:flutter/material.dart';

import '../../ivalidator.dart';

class CheckRepetitions implements IInputValidator {
  final String? errorMessage;
  final String previousPassword;

  CheckRepetitions({this.errorMessage, required this.previousPassword});

  @override
  bool isValid(BuildContext context, String? value) =>
      value == previousPassword ? true : false;

  @override
  String message(BuildContext context) {
    return errorMessage ?? "تکرار رمز عبور اشتباه است";
  }
}
