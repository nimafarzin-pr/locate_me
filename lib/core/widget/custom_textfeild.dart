import 'package:flutter/material.dart';

import '../utils/validators/input/input_validate.dart';
import '../utils/validators/input/input_validate_Item/empty_data.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final Color? cursorColor;
  final FormFieldValidator<String>? validator;
  // Add any other properties you might need

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.hintStyle,
    this.fillColor,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.cursorColor,
    this.validator,
    // Initialize any other properties with default values if needed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        validator: validator ??
            (value) {
              return ValidateInput.schema(
                context: context,
                value: value.toString(),
                validations: [
                  EmptyData(
                    errorMessage: 'Field is required',
                  ),
                ],
              );
            },
        decoration: InputDecoration(
          helperText: '',
          hintText: hintText,
          hintStyle: hintStyle ?? TextStyle(color: Colors.grey[400]),
          filled: true,
          fillColor: fillColor ?? Colors.white,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          border: border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.greenAccent,
                  width: 2.0,
                ),
              ),
          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.greenAccent,
                  width: 2.0,
                ),
              ),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.lightGreen,
                  width: 2.0,
                ),
              ),
          errorBorder: errorBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
              ),
          focusedErrorBorder: focusedErrorBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 2.0,
                ),
              ),
        ),
        cursorColor: cursorColor ?? Colors.blueAccent,
      ),
    );
  }
}
