import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import 'custom_text.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const FaIcon(FontAwesomeIcons.inbox),
        const SizedBox(height: 12),
        CustomText.labelSmall(LocaleKeys.empty_list.tr())
      ],
    );
  }
}
