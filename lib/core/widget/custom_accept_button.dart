import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingProvider = StateProvider<bool>((ref) => false);

class AcceptButton extends StatelessWidget {
  final String buttonText;
  final Future<void> Function() onPressed;

  const AcceptButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final isLoading = ref.watch(loadingProvider);

        return Center(
          child: Container(
            height: 48,
            width: 200,
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.greenAccent,
                width: 2.0,
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.greenAccent.withOpacity(0.5),
                  Colors.green.withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: TextButton(
              onPressed: () async {
                if (isLoading) return;
                ref.read(loadingProvider.notifier).state = true;
                await onPressed();
                ref.read(loadingProvider.notifier).state = false;
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 30.0),
                backgroundColor: Colors.transparent,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(buttonText),
            ),
          ),
        );
      },
    );
  }
}
