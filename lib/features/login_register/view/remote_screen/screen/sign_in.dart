import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/navigation/routes.dart';
import 'package:locate_me/core/resources/icons.dart';
import 'package:locate_me/core/widget/accept_button/custom_accept_button.dart';
import 'package:locate_me/core/widget/background_wrapper.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/core/widget/custom_textfeild.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/login_register//provider/auth_notifier_provider.dart';

import '../../../../../core/widget/error_widget_box.dart';
import '../../../../../generated/locale_keys.g.dart';
import 'sign_up.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () async {
        await checkSession();
      },
    );
  }

  Future checkSession() async {
    final auth = ref.read(authNotifierProvider.notifier);
    await auth.signIn(_emailController.text, _passwordController.text);
    final session = await auth.getCurrentSession();
    log('____>> ${session.isAuthenticated}');
    if (session.isAuthenticated) {
      context.go(Routes.root);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    if (authState.isLoading) {
      return const MyLoading();
    }

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

    if (authState.hasValue) {
      if (!(authState.value!.isAuthenticated)) {
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
                        buttonText: LocaleKeys.signIn.tr(),
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
                            builder: (context) =>
                                const BackgroundWrapper(child: SignUpScreen()),
                          ),
                        );
                      },
                      child: CustomText.bodyLarge(
                          LocaleKeys.not_register_user_txt.tr()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }

    return const MyLoading();
  }
}
