import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/navigation/routes.dart';
import '../../../../../core/resources/icons.dart';
import '../../../../../core/utils/validators/input/input_validate.dart';
import '../../../../../core/utils/validators/input/input_validate_Item/empty_data.dart';
import '../../../../../core/widget/accept_button/custom_accept_button.dart';
import '../../../../../core/widget/custom_text.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../widgets/otp_widget.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
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
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(MyIcons.logo), fit: BoxFit.cover),
                ),
              ),
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
                        value: value.toString(),
                        validations: [
                          EmptyData(
                            errorMessage: LocaleKeys.field_required.tr(),
                          ),
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
                        value: value.toString(),
                        validations: [
                          EmptyData(
                            errorMessage: LocaleKeys.field_required.tr(),
                          ),
                        ],
                      );
                    },
                    controller: _repeatPasswordController,
                    length: 6,
                    obscureText: true,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
              SizedBox(
                width: 200,
                child: AcceptButton(
                  buttonText: LocaleKeys.accept.tr(),
                  onPressed: () async {
                    // if (!_formKey.currentState!.validate()) {
                    //   return;
                    // }

                    context.go(Routes.loginRouteForNavigator);
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
