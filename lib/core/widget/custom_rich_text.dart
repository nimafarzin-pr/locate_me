import 'package:flutter/material.dart';
import 'package:locate_me/core/constant/constant_names.dart';

class CustomRichText extends StatelessWidget {
  final String title;
  final String value;
  const CustomRichText({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        // textAlign: TextAlign.left,
        text: TextSpan(
          text: title,
          style: TextStyle(
              fontFamily: appFontFamily,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).colorScheme.onSurface),
          children: <TextSpan>[
            TextSpan(
                text: value,
                style: const TextStyle(
                    fontWeight: FontWeight.w100, fontFamily: appFontFamily)),
          ],
        ),
      ),
    );
  }
}
