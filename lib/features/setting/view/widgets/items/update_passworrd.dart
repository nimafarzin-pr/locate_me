// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:locate_me/core/extension/theme_extension.dart';
import 'package:locate_me/core/widget/dialogs/error_dialog.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../../core/utils/validators/input/input_validate.dart';
import '../../../../../core/utils/validators/input/input_validate_Item/check_repetitions.dart';
import '../../../../../core/utils/validators/input/input_validate_Item/empty_data.dart';
import '../../../../../core/utils/validators/input/input_validate_Item/length_check.dart';
import '../../../../../core/widget/cancel_button.dart';
import '../../../../../core/widget/accept_button/custom_accept_button.dart';
import '../../../../../core/widget/custom_text.dart';
import '../../../../../core/widget/custom_textfeild.dart';
import '../../../../../core/widget/dialogs/dialog_wrapper.dart';
import '../../../../../core/widget/dialogs/status_widget.dart';
import '../../../../../core/widget/dialogs/success_modal.dart';
import '../../../provider/settings_provider.dart';

class UpdatePassword extends StatefulWidget {
  final TextEditingController password;
  final TextEditingController repeatPassword;
  final Future<dynamic> Function(String password) onPressed;
  const UpdatePassword(
      {super.key,
      required this.repeatPassword,
      required this.password,
      required this.onPressed});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
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
      child: DialogWrapper(
        height: MediaQuery.sizeOf(context).height / 2,
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
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Theme.of(context).colorScheme.warning,
                        size: 50,
                      ),
                      const SizedBox(height: 20),
                      CustomText.headlineSmall(
                        LocaleKeys.change_Password.tr(),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        maxLength: 6,
                        validator: (value) {
                          return ValidateInput.schema(
                            context: context,
                            value: value ?? widget.password.text,
                            validations: [
                              EmptyData(
                                errorMessage: LocaleKeys.field_required.tr(),
                              ),
                              LengthCheck(
                                  length: 6,
                                  errorMessage: LocaleKeys
                                      .input_length_error_message
                                      .tr()),
                            ],
                          );
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        hintText: LocaleKeys.enter_password.tr(),
                        controller: widget.password,
                      ),
                      CustomTextField(
                        maxLength: 6,
                        validator: (value) {
                          return ValidateInput.schema(
                            context: context,
                            value: value ?? widget.repeatPassword.text,
                            validations: [
                              EmptyData(
                                errorMessage: LocaleKeys.field_required.tr(),
                              ),
                              LengthCheck(
                                  length: 6,
                                  errorMessage: LocaleKeys
                                      .input_length_error_message
                                      .tr()),
                              CheckRepetitions(
                                  previousPassword: widget.password.text)
                            ],
                          );
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        hintText: LocaleKeys.repeat_password.tr(),
                        controller: widget.repeatPassword,
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
                              widget.onPressed(widget.password.text);
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
    );
  }
}

Future<void> showChangePasswordModal(
    BuildContext context,
    TextEditingController password,
    TextEditingController repeatPassword) async {
  await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (ctx) => Consumer(builder: (context, ref, child) {
      return UpdatePassword(
          password: password,
          repeatPassword: repeatPassword,
          onPressed: (password) async {
            final status = await ref
                .read(changePasswordNotifierProvider.notifier)
                .updatePassword(password);

            if (status) {
              Navigator.pop(ctx);
              await showSuccessModal(context);
            } else {
              showErrorDialog(
                  context: context, content: LocaleKeys.error_occurred.tr());
            }
          });
    }),
  );
}
