import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';
import 'dialogs/status_widget.dart';

class ErrorWidgetBox extends StatelessWidget {
  const ErrorWidgetBox({
    super.key,
    required this.onConfirm,
    required this.context,
    required this.buttonTitle,
    required this.content,
  });

  final Future<void> Function()? onConfirm;
  final BuildContext context;
  final String buttonTitle;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicHeight(
        child: Center(
          child: StatusWidget(
              onConfirm: onConfirm,
              acceptButtonTitle: buttonTitle,
              showCancelButton: false,
              title: LocaleKeys.error.tr(),
              content: content,
              iconColor: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}
