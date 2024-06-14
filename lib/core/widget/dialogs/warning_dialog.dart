import 'package:flutter/material.dart';
import 'package:locate_me/core/widget/warning_widget.dart';

void showWarningDialog({
  required BuildContext context,
  required String title,
  String content = 'Do you want to continue?',
  required VoidCallback onConfirm,
  bool showCancelButton = true,
}) {
  showDialog(
    context: context,
    builder: (context) => WarningWidget(
      showCancelButton: showCancelButton,
      title: title,
      content: content,
      onConfirm: onConfirm,
    ),
  );
}
