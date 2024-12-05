// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../../core/widget/accept_button/custom_accept_button.dart';
import '../../../../../core/widget/custom_text.dart';
import '../../../../../core/widget/dialogs/dialog_wrapper.dart';
import '../../../../../core/widget/animation/fade_in_scale_animation.dart';

class AddRate extends StatefulWidget {
  const AddRate({super.key});

  @override
  State<AddRate> createState() => _AddRateState();
}

class _AddRateState extends State<AddRate> {
  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: () async {
        Navigator.pop(context);
        return true;
      },
      child: FadeInScaleAnimation(
        child: DialogWrapper(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText.headlineMedium(LocaleKeys.rate_dialog_title.tr()),
                const SizedBox(height: 24),
                CustomText.bodyLarge(LocaleKeys.add_rate_request_message.tr()),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(10),
                          )),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: CustomText.bodyLarge(
                            LocaleKeys.cancel.tr(),
                            customStyle: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.5),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    AcceptButton(
                      buttonText: LocaleKeys.ok.tr(),
                      onPressed: () async {
                        Navigator.pop(context);
                        const platform =
                            MethodChannel("com.example.locate_me/native");
                        try {
                          await platform.invokeMethod("openMyketUrl");
                        } on PlatformException catch (e) {
                          // Handle the error gracefully
                          log("Failed to open Myket URL: ${e.message}");
                        }
                        //Todo open rate dialog
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> showRateModal(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => const AddRate(),
  );
}
