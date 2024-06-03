import 'package:flutter/material.dart';

import '../../ivalidator.dart';

class EmptyData implements IInputValidator {
  final String? errorMessage;

  EmptyData({this.errorMessage});
  @override
  String message(BuildContext context) {
    return errorMessage ?? "";
  }

  @override
  bool isValid(BuildContext context, String? value) {
    return value!.isNotEmpty;
  }
}
