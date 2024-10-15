// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:locate_me/core/extension/theme_extension.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../../core/widget/cancel_button.dart';
import '../../../../../core/widget/accept_button/custom_accept_button.dart';
import '../../../../../core/widget/custom_text.dart';
import '../../../../../core/widget/custom_textfeild.dart';
import '../../../../../core/widget/dialogs/dialog_wrapper.dart';
import '../../../../../core/widget/dialogs/status_widget.dart';
import '../../../../../core/widget/animation/fade_in_scale_animation.dart';
import '../../../provider/settings_provider.dart';

class ExportModal extends StatefulWidget {
  final TextEditingController fileName;

  const ExportModal({super.key, required this.fileName});

  @override
  State<ExportModal> createState() => _ExportModalState();
}

class _ExportModalState extends State<ExportModal> {
  final formKey = GlobalKey<FormState>();
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: () async {
        Navigator.pop(context);
        return true;
      },
      child: FadeInScaleAnimation(
        child: DialogWrapper(
          child: Consumer(
            builder: (context, ref, child) {
              final state = ref.watch(exportNotifierProvider);
              if (state.isLoading) {
                return MyLoading(color: Theme.of(context).colorScheme.primary);
              } else if (state.successMessage != null) {
                return StatusWidget(
                  title: LocaleKeys.export.tr(),
                  iconColor: Theme.of(context).colorScheme.success,
                  content: state.successMessage,
                  showCancelButton: false,
                  onConfirm: () async {
                    Navigator.pop(context);
                  },
                );
              } else if (state.errorMessage != null) {
                return StatusWidget(
                  title: LocaleKeys.export.tr(),
                  iconColor: Theme.of(context).colorScheme.error,
                  content: state.errorMessage,
                  showCancelButton: false,
                  onConfirm: () async {
                    Navigator.pop(context);
                  },
                );
              } else {
                return Builder(builder: (bContext) {
                  return Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Theme.of(context).colorScheme.warning,
                          size: 50,
                        ),
                        const SizedBox(height: 20),
                        CustomText.headlineSmall(
                          LocaleKeys.export.tr(),
                        ),
                        const SizedBox(height: 10),
                        CustomText.bodySmall(
                          LocaleKeys.export_hint.tr(),
                          textAlign: TextAlign.center,
                          customStyle: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          hintText: LocaleKeys.title.tr(),
                          controller: widget.fileName,
                          focusNode: focusNode,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CancelButton(),
                            const SizedBox(width: 12),
                            AcceptButton(
                              buttonText: LocaleKeys.ok.tr(),
                              onPressed: () async {
                                if (!(formKey.currentState!.validate())) {
                                  return;
                                }
                                final req =
                                    ref.read(exportNotifierProvider.notifier);
                                await req.exportData(widget.fileName.text);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<void> showExportModal(
    BuildContext context, TextEditingController fileName) async {
  await showDialog(
    context: context,
    builder: (context) => ExportModal(fileName: fileName),
  );
}
