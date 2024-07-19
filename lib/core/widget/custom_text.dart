import 'package:flutter/material.dart';
import '../sizing/my_text_size.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final TextWidthBasis? textWidthBasis;

  CustomText.headlineMedium(
    this.text, {
    super.key,
    TextStyle? customStyle,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.textScaler,
    this.textWidthBasis,
  }) : style = AppTextFontsAndSizing.headlineMedium.merge(customStyle);

  CustomText.headlineSmall(
    this.text, {
    super.key,
    TextStyle? customStyle,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.textScaler,
    this.textWidthBasis,
  }) : style = AppTextFontsAndSizing.headlineSmall.merge(customStyle);

  CustomText.bodyLarge(
    this.text, {
    super.key,
    TextStyle? customStyle,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.textScaler,
    this.textWidthBasis,
  }) : style = AppTextFontsAndSizing.bodyLarge.merge(customStyle);

  CustomText.bodySmall(
    this.text, {
    super.key,
    TextStyle? customStyle,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.textScaler,
    this.textWidthBasis,
  }) : style = AppTextFontsAndSizing.bodySmall.merge(customStyle);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      textScaler: textScaler,
      textWidthBasis: textWidthBasis,
    );
  }
}
