import 'package:flutter/material.dart';

import '../../../../../core/widget/dialogs/custom_map_options.dart';

void showMapSettingsModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return CustomMapOptionsDialog(
        onOptionSelected: (p0) {},
      );
    },
  );
}
