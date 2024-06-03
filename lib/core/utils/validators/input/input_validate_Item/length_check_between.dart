import 'package:flutter/material.dart';
import '../../ivalidator.dart';

class LengthCheckBetween implements IInputValidator {
  final int minLength;
  final int maxLength;
  final String errorMessage;

  LengthCheckBetween({required this.minLength,required this.maxLength, required this.errorMessage});

  @override
  bool isValid(BuildContext context, String? value) =>
      value!.length >= minLength && value.length <= maxLength;

  @override
  String message(BuildContext context) {
    return errorMessage;
  }
}
