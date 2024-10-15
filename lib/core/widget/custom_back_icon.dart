import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../features/setting/provider/settings_provider.dart';

class CustomBackIcon extends StatelessWidget {
  const CustomBackIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Center(
          child: FaIcon(
            ref.watch(languageNotifierProvider).asData?.value == 'fa'
                ? FontAwesomeIcons.chevronRight
                : FontAwesomeIcons.chevronLeft,
            size: 18,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        );
      },
    );
  }
}
