import 'package:flutter/material.dart';
import 'package:locate_me/core/extension/screen_size.dart';
import 'package:locate_me/core/widget/custom_text.dart';

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

  const CustomDropdownField({
    super.key,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemAsString,
    this.validator,
    required this.itemAsWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<T>(
        menuMaxHeight: context.screenHeight / 3,
        hint: Align(
          alignment: Alignment.centerLeft,
          child: CustomText.bodyLarge(
            hintText,
            customStyle: TextStyle(
              color: Colors.grey[400],
            ),
          ),
        ),
        decoration: InputDecoration(
          alignLabelWithHint: true,
          filled: true,
          fillColor: Colors.white,
          helperText: '',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.greenAccent,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.greenAccent,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.lightGreen,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 2.0,
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
                    errorMessage: 'Field is required',
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
