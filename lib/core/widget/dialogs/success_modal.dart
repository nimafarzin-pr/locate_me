import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../generated/locale_keys.g.dart';
import 'status_widget.dart';

Future<void> showSuccessModal(BuildContext context,
    {Future<dynamic> Function()? onConfirm}) async {
  await showDialog(
    context: context,
    builder: (successModal) {
      return Center(
        child: SizedBox(
          height: 300,
          child: StatusWidget(
              status: ActionStatus.success,
              onConfirm: () async {
                if (onConfirm != null) {
                  Navigator.pop(successModal);
                  await onConfirm();
                } else {
                  await Navigator.maybePop(successModal);
                }
              },
              showCancelButton: false,
              iconColor: Colors.green,
              title: LocaleKeys.success_full_action.tr()),
        ),
      );
    },
  );
}
