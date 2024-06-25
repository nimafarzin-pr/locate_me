import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:locate_me/core/extension/theme_extension.dart';
import 'package:locate_me/core/sizing/my_text_size.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/core/widget/dialogs/warning_dialog.dart';
import 'package:locate_me/core/widget/loading.dart';

import '../sizing/app_sizing.dart';

final loadingProvider = StateProvider<bool>((ref) => false);

class AcceptButton extends ConsumerWidget {
  final String buttonText;
  final Future<void> Function() onPressed;

  const AcceptButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);
    return Center(
      child: Container(
        height: 44,
        // width: 100,
        margin: const EdgeInsets.symmetric(vertical: AppSizes.smallMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.smallBorderRadius),
          border: Border.all(
            color: Theme.of(context).colorScheme.surface,
            width: AppSizes.mediumBorderWidth,
          ),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.5),
              Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ElevatedButton(
          onPressed: () async {
            if (isLoading) return;
            try {
              ref.read(loadingProvider.notifier).state = true;
              await onPressed();
              ref.read(loadingProvider.notifier).state = false;
            } catch (e) {
              ref.read(loadingProvider.notifier).state = false;
            } finally {
              ref.read(loadingProvider.notifier).state = false;
            }
          },
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.onPrimary),
            backgroundColor: WidgetStateProperty.all(Colors.transparent),
            overlayColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.primary.withOpacity(0.1)),
            textStyle: WidgetStateProperty.all(
              TextStyle(
                fontSize: AppTextFontsAndSizing.titleLargeFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            shadowColor: WidgetStateProperty.all(
                Colors.transparent), // Remove shadow if needed
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(8), // Adjust border radius as needed
              ),
            ),
          ),
          child: Center(
            child: isLoading
                ? const MyLoading(
                    size: 16,
                  )
                : CustomText.bodyLarge(buttonText),
          ),
        ),
      ),
    );
  }
}
