import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/navigation/routes.dart';
import 'package:locate_me/features/login_register/view/local_screen/provider/login_register_provider.dart';

import '../../../../../core/resources/icons.dart';
import '../../../../../core/utils/validators/input/input_validate.dart';
import '../../../../../core/utils/validators/input/input_validate_Item/empty_data.dart';
import '../../../../../core/widget/accept_button/custom_accept_button.dart';
import '../../../../../core/widget/custom_text.dart';
import '../../../../../core/widget/custom_textfeild.dart';
import '../../../../../core/widget/dialogs/error_dialog.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../widgets/otp_widget.dart';

class LocalLoginScreen extends ConsumerStatefulWidget {
  const LocalLoginScreen({super.key});

  @override
  ConsumerState<LocalLoginScreen> createState() => _LocalLoginScreenState();
}

class _LocalLoginScreenState extends ConsumerState<LocalLoginScreen> {
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
                height: MediaQuery.sizeOf(context).height / 3,
                width: MediaQuery.sizeOf(context).width / 1.2,
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
                  CustomTextField(
                    maxLength: 6,
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
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    hintText: LocaleKeys.repeat_password.tr(),
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              SizedBox(
                width: 200,
                child: AcceptButton(
                  buttonText: LocaleKeys.accept.tr(),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    final authenticate = await ref
                        .read(loginNotifierProvider.notifier)
                        .authenticate(
                            enteredPassword: _passwordController.text);

                    if (authenticate) {
                      context.go(Routes.root);
                    } else {
                      showErrorDialog(
                          content: LocaleKeys.wrong_password.tr(),
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
