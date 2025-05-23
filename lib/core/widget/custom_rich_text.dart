// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:locate_me/core/constant/constant_names.dart';
import 'package:locate_me/core/sizing/my_text_size.dart';

class CustomRichText extends StatelessWidget {
  final String title;
  final String value;
  final int? maxLines;
  const CustomRichText({
    super.key,
    required this.title,
    required this.value,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: RichText(
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        // textAlign: TextAlign.left,
        text: TextSpan(
          text: title,
          style: TextStyle(
              fontSize: AppTextFontsAndSizing.bodyMediumFontSize,
              fontFamily: appFontFamily,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).colorScheme.onSurface),
          children: <TextSpan>[
            TextSpan(
                text: value,
                style: TextStyle(
                    fontSize: AppTextFontsAndSizing.bodySmallFontSize,
                    fontWeight: FontWeight.w100,
                    fontFamily: appFontFamily)),
          ],
        ),
      ),
    );
  }
}
