// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:locate_me/core/sizing/my_text_size.dart';

import '../../generated/locale_keys.g.dart';
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
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextAlign textAlign;
  // Add any other properties you might need

  const CustomTextField({
    super.key,
    // Initialize any other properties with default values if needed
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
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.focusNode,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        textAlign: textAlign,
        style: TextStyle(
            fontSize: AppTextFontsAndSizing.bodySmallFontSize,
            color: readOnly
                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                : null),
        readOnly: readOnly,
        onChanged: onChanged,
        focusNode: null,
        controller: controller,
        autofocus: false,
        validator: validator ??
            (value) {
              return ValidateInput.schema(
                context: context,
                value: value.toString(),
                validations: [
                  EmptyData(
                    errorMessage: LocaleKeys.field_required.tr(),
                  ),
                ],
              );
            },
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: hintStyle ?? TextStyle(color: Colors.grey[400]),
          filled: true,
          fillColor:
              fillColor ?? Theme.of(context).colorScheme.surfaceContainer,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          border: border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.0,
                ),
              ),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 1.0,
                ),
              ),
          errorBorder: errorBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1.0,
                ),
              ),
          focusedErrorBorder: focusedErrorBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1.0,
                ),
              ),
        ),
        cursorColor: cursorColor ?? Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
