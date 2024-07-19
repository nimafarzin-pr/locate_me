// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:locate_me/core/widget/accept_button/custom_accept_button.dart';
import 'package:locate_me/generated/locale_keys.g.dart';

import '../custom_text.dart';
import '../animation/fade_in_scale_animation.dart';

class StatusWidget extends StatefulWidget {
  final String title;
  final String? content;
  final Color? iconColor;
  final Future<void> Function()? onConfirm;
  final bool showCancelButton;
  final bool disableButtons;
  final String? acceptButtonTitle;

  const StatusWidget({
    super.key,
    required this.title,
    this.content,
    this.iconColor,
    this.onConfirm,
    this.showCancelButton = true,
    this.disableButtons = false,
    this.acceptButtonTitle,
  });

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  @override
  Widget build(BuildContext context) {
    return FadeInScaleAnimation(
      beginScale: 0.2,
      duration: const Duration(milliseconds: 300),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color:
                      widget.iconColor ?? Theme.of(context).colorScheme.error,
                  size: 50,
                ),
                const SizedBox(height: 20),
                CustomText.bodyLarge(
                  widget.title,
                  customStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 10),
                widget.content != null
                    ? CustomText.bodyLarge(
                        widget.content!,
                        textAlign: TextAlign.center,
                        customStyle: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.5),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 20),
                widget.disableButtons
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.showCancelButton
                              ? Row(
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                      onPressed: () {
                                        Navigator.of(context).pop();
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
                                )
                              : const SizedBox(),
                          AcceptButton(
                            buttonText:
                                widget.acceptButtonTitle ?? LocaleKeys.ok.tr(),
                            onPressed: () async {
                              if (widget.onConfirm == null) {
                                Navigator.of(context).pop();
                              } else {
                                await widget.onConfirm!();
                              }
                            },
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
