import 'package:flutter/material.dart';

import '../ivalidator.dart';

class ValidateInput {
  static String? schema({
    required BuildContext context,
    required String value,
    required List<IInputValidator> validations,
  }) {
    for (var method in validations) {
      final bool state = method.isValid(context, value);
      if (!state) {
        return method.message(context);
      }
    }
    return null;
  }
}
