import 'package:flutter/material.dart';

abstract class IInputValidator implements IValidator {
  bool isValid(BuildContext context, String? value);

  String message(BuildContext context);
}

abstract class IValidator {}
