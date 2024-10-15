import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/widget/dialogs/error_dialog.dart';
import 'package:locate_me/features/login/view/screen/sign_in.dart';

import '../../../../core/navigation/routes.dart';
import '../../../../core/resources/icons.dart';
import '../../../../core/widget/accept_button/custom_accept_button.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/custom_textfeild.dart';
import '../../../../core/widget/error_widget_box.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../provider/auth_notifier_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future checkSession() async {
    final auth = ref.read(authNotifierProvider.notifier);
    final authState = ref.read(authNotifierProvider);
    await auth.signUp(_emailController.text, _passwordController.text);

    final canGoToApp = authState.hasValue && authState.value!.isAuthenticated;
    if (canGoToApp) {
      context.go(Routes.root);
    } else {
      if (authState.hasValue) {
        showErrorDialog(context: context, content: authState.value!.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    if (authState.hasError) {
      final error = authState.error;
      return ErrorWidgetBox(
        content: error.toString(),
        buttonTitle: LocaleKeys.refresh_accept.tr(),
        context: context,
        onConfirm: () async {
          await ref.read(authNotifierProvider.notifier).getCurrentSession();
        },
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(width: 260, height: 260, MyIcons.logo),
                CustomTextField(
                  textAlign: TextAlign.center,
                  controller: _emailController,
                  hintText: 'example@gmail.com',
                ),
                CustomTextField(
                  textAlign: TextAlign.center,
                  controller: _passwordController,
                  hintText: 'Aa123456',
                  obscureText: true,
                ),
                SizedBox(
                  width: 200,
                  child: AcceptButton(
                    buttonText: LocaleKeys.signUp.tr(),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      await checkSession();
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  child:
                      CustomText.bodyLarge(LocaleKeys.register_user_txt.tr()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
