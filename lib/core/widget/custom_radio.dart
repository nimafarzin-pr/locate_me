// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String title;
  final bool isSelect;
  final void Function(T?) onChanged;

  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.isSelect,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Radio<T>(
              activeColor: isSelect
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.transparent,
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            CustomText.labelSmall(title),
          ],
        ),
      ),
    );
  }
}
