import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/extension/theme_extension.dart';
import 'package:locate_me/core/widget/dialogs/diolog_wrapper.dart';
import 'package:locate_me/core/widget/loading.dart';

import '../../../../../core/widget/dialogs/status_widget.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../provider/export_import_notifier.dart';

Future<void> showImportModal(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return DialogWrapper(
        child: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(importNotifierProvider);
            if (state.isLoading) {
              return const Center(child: MyLoading());
            } else if (state.successMessage != null) {
              return StatusWidget(
                title: LocaleKeys.import.tr(),
                iconColor: Theme.of(context).colorScheme.success,
                content: state.successMessage,
                showCancelButton: false,
                onConfirm: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                  ref.invalidate(importNotifierProvider);
                },
              );
            } else if (state.errorMessage != null) {
              return StatusWidget(
                title: LocaleKeys.import.tr(),
                iconColor: Theme.of(context).colorScheme.error,
                content: state.errorMessage,
                showCancelButton: false,
                onConfirm: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                  ref.invalidate(importNotifierProvider);
                },
              );
            } else {
              if (state.isCancel == true) {
                Navigator.of(context).pop();
              }
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(importNotifierProvider.notifier).importData();
                  },
                  child: const Text('Start Import'),
                ),
              );
            }
          },
        ),
      );
    },
  );
}
