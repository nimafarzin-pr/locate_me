import 'package:flutter/material.dart';

import '../../../../../core/common_features/map/views/widgets/dialog/custom_map_options.dart';

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
