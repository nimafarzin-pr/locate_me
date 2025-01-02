import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/widget/dialogs/error_dialog.dart';
import 'package:locate_me/features/login_register/view/local_screen/provider/login_register_provider.dart';

import '../../../../../core/navigation/routes.dart';
import '../../../../../core/resources/icons.dart';
import '../../../../../core/utils/validators/input/input_validate.dart';
import '../../../../../core/utils/validators/input/input_validate_Item/check_repetitions.dart';
import '../../../../../core/utils/validators/input/input_validate_Item/empty_data.dart';
import '../../../../../core/utils/validators/input/input_validate_Item/length_check.dart';
import '../../../../../core/widget/accept_button/custom_accept_button.dart';
import '../../../../../core/widget/custom_text.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../widgets/otp_widget.dart';

class SetPasswordScreen extends ConsumerStatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  ConsumerState<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends ConsumerState<SetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 24),
              Flexible(
                flex: 1,
                child: Container(
                  height: MediaQuery.sizeOf(context).height / 3.5,
                  width: MediaQuery.sizeOf(context).width / 1.2,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(MyIcons.logo), fit: BoxFit.contain),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText.bodySmall(LocaleKeys.enter_password.tr(),
                      customStyle: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  SquareOtpField(
                    validator: (value) {
                      return ValidateInput.schema(
                        context: context,
                        value: value ?? _passwordController.text,
                        validations: [
                          EmptyData(
                            errorMessage: LocaleKeys.field_required.tr(),
                          ),
                          LengthCheck(
                              length: 6,
                              errorMessage: 'رمز عبور باید ۶ رقم باشد'),
                        ],
                      );
                    },
                    controller: _passwordController,
                    length: 6, // Adjust length as needed
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  CustomText.bodySmall(LocaleKeys.repeat_password.tr(),
                      customStyle: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  SquareOtpField(
                    validator: (value) {
                      return ValidateInput.schema(
                        context: context,
                        value: value ?? _repeatPasswordController.text,
                        validations: [
                          EmptyData(
                            errorMessage: LocaleKeys.field_required.tr(),
                          ),
                          LengthCheck(
                              length: 6,
                              errorMessage: 'رمز عبور باید ۶ رقم باشد'),
                          CheckRepetitions(
                              previousPassword: _passwordController.text)
                        ],
                      );
                    },
                    controller: _repeatPasswordController,
                    length: 6,
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
              // const SizedBox(height: 24),
              SizedBox(
                width: 200,
                child: AcceptButton(
                  buttonText: LocaleKeys.accept.tr(),
                  onPressed: () async {
                    if (!(_formKey.currentState!.validate())) {
                      return;
                    }
                    log('12312');

                    final isPasswordSetDone = await ref
                        .read(setPasswordNotifierProvider.notifier)
                        .setPassword(password: _passwordController.text.trim());

                    log("_+_+$isPasswordSetDone");
                    if (isPasswordSetDone) {
                      context.go(Routes.loginRouteForNavigator);
                    } else {
                      showErrorDialog(
                          content: LocaleKeys.error_occurred.tr(),
                          context: context,
                          showCancelButton: false);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
