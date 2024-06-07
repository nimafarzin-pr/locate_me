import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locate_me/core/extension/screen_size.dart';
import 'package:locate_me/core/widget/custom_text.dart';

import '../dto/category_dto.dart';

class CategoryBox extends StatelessWidget {
  final CategoryItem item;
  final VoidCallback onTap;
  final bool isSelected;

  const CategoryBox({
    super.key,
    required this.item,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
        // color: isSelected
        //     ? Theme.of(context).colorScheme.primary
        //     : Theme.of(context).colorScheme.surface,
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 1,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Container(
              alignment: Alignment.center,
              // margin: EdgeInsets.all(4.w),
              // padding: EdgeInsets.all(3.w),
              // width: context.screenWidth * 0.16,
              // height: context.screenHeight * 0.16,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        width: 34.w,
                        height: 16.w,
                        item.icon,
                        color: isSelected
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Expanded(
                      child: CustomText.bodyLarge(
                        item.name,
                        maxLines: 1,
                        customStyle: TextStyle(
                            // fontSize: 12,
                            color: isSelected
                                ? Theme.of(context).colorScheme.onSecondary
                                : Theme.of(context).colorScheme.onSurface),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
