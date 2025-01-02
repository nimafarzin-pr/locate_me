// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:locate_me/core/sizing/my_text_size.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/setting/provider/settings_provider.dart';

import '../../generated/locale_keys.g.dart';
import '../utils/validators/input/input_validate.dart';
import '../utils/validators/input/input_validate_Item/empty_data.dart';
import 'dart:ui' as ui;

class CustomTextField extends StatefulWidget {
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
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLength;
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
    this.obscureText = false,
    this.keyboardType,
    this.maxLength,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool visibility = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 66,
        child: widget.obscureText
            ? input('en', context)
            : Consumer(builder: (context, ref, child) {
                return ref.watch(languageNotifierProvider).when(
                    data: (language) {
                      return input(language, context);
                    },
                    error: (error, stackTrace) => const MyLoading(),
                    loading: () => const MyLoading());
              }),
      ),
    );
  }

  Directionality input(String language, BuildContext context) {
    return Directionality(
      textDirection: widget.obscureText
          ? ui.TextDirection.ltr
          : (language == 'fa' || language == 'ar'
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        obscureText: visibility ? widget.obscureText : false,
        textAlign: widget.textAlign,
        style: TextStyle(
            fontSize: AppTextFontsAndSizing.bodySmallFontSize,
            color: widget.readOnly
                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.5)
                : null),
        readOnly: widget.readOnly,
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
        controller: widget.controller,
        autofocus: widget.autofocus,
        validator: widget.validator ??
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
          // constraints: const BoxConstraints(
          //     minHeight: 20, maxHeight: 20, maxWidth: 300, minWidth: 30),

          helper: const Text(" "),
          prefix: const SizedBox(
            width: 20,
          ),
          suffixIcon: widget.suffixIcon ??
              (widget.obscureText
                  ? SizedBox(
                      // color: Colors.red,
                      width: 20,
                      child: IconButton(
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero, // Removes default padding
                          alignment: Alignment.center,
                          // Removes size constraints

                          onPressed: () {
                            setState(() {
                              visibility = !visibility;
                            });
                          },
                          icon: Icon(
                            visibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 18,
                          )),
                    )
                  : null),
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ?? TextStyle(color: Colors.grey[400]),
          filled: true,
          fillColor: widget.fillColor ??
              Theme.of(context).colorScheme.surfaceContainer,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          border: widget.border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 1.0,
                ),
              ),
          enabledBorder: widget.enabledBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 1.0,
                ),
              ),
          focusedBorder: widget.focusedBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.0,
                ),
              ),
          errorBorder: widget.errorBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1.0,
                ),
              ),
          focusedErrorBorder: widget.focusedErrorBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                  width: 1.0,
                ),
              ),
        ),
        cursorColor:
            widget.cursorColor ?? Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
