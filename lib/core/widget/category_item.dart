import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locate_me/core/widget/custom_text.dart';

import '../common_features/category/dto/category_dto.dart';
import '../sizing/app_sizing.dart';

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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.smallBorderRadius),
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
            : Theme.of(context).colorScheme.surfaceContainer,
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
                  Radius.circular(AppSizes.smallBorderRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.smallPadding),
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
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Expanded(
                      child: CustomText.labelSmall(
                        item.translationKey.tr(),
                        maxLines: 1,
                        customStyle: TextStyle(
                            color: isSelected
                                ? Theme.of(context).colorScheme.surface
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
