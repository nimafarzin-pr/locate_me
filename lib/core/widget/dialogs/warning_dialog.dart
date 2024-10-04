import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:locate_me/core/widget/dialogs/status_widget.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import 'dialog_wrapper.dart';

void showWarningDialog({
  required BuildContext context,
  required String title,
  String? content,
  Color? iconColor,
  required Future<void> Function() onConfirm,
  bool showCancelButton = true,
}) {
  showDialog(
    context: context,
    builder: (context) => DialogWrapper(
      child: BackButtonListener(
        onBackButtonPressed: () async {
          Navigator.pop(context);
          return true;
        },
        child: StatusWidget(
          iconColor: iconColor,
          showCancelButton: showCancelButton,
          title: title,
          content: content ?? LocaleKeys.do_you_want_to_continue.tr(),
          onConfirm: () async {
            onConfirm();
            Navigator.pop(context);
          },
        ),
      ),
    ),
  );
}
