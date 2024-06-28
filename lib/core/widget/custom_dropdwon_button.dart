// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:locate_me/core/extension/screen_size.dart';
import 'package:locate_me/core/sizing/my_text_size.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../utils/validators/input/input_validate.dart';
import '../utils/validators/input/input_validate_Item/empty_data.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String hintText;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemAsString;
  final FormFieldValidator<T>? validator;
  final Row Function(T) itemAsWidget;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;

  const CustomDropdownField({
    super.key,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemAsString,
    this.validator,
    required this.itemAsWidget,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<T>(
        menuMaxHeight: context.screenHeight / 3,
        hint: Align(
          alignment: Alignment.centerLeft,
          child: CustomText.bodySmall(
            hintText,
            customStyle: TextStyle(
              color: Colors.grey[400],
            ),
          ),
        ),
        style: TextStyle(
            fontSize: AppTextFontsAndSizing.bodySmallFontSize,
            color: Theme.of(context).colorScheme.onSurface),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainer,
          helperText: '',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.greenAccent,
                  width: 1.0,
                ),
              ),
          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface,
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
        value: value,
        onChanged: onChanged,
        validator: validator ??
            (value) {
              return ValidateInput.schema(
                context: context,
                value: value != null ? value.toString() : '',
                validations: [
                  EmptyData(
                    errorMessage: LocaleKeys.field_required.tr(),
                  ),
                ],
              );
            },
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: itemAsWidget(item),
          );
        }).toList(),
      ),
    );
  }
}
