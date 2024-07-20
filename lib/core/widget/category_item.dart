import 'package:flutter/material.dart';
import 'package:locate_me/core/utils/icon_picker_utils.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/features/setting/model/category_model.dart';

import '../sizing/app_sizing.dart';

class CategoryBox extends StatelessWidget {
  final CategoryModel item;
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
    final icon = IconPickerUtils.iconPickerDeserializer(item.iconString);
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.smallBorderRadius),
          side: BorderSide(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 2),
        ),
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Container(
              alignment: Alignment.center,
              // margin: EdgeInsets.all(4.w),
              // padding: EdgeInsets.all(3.w),
              // width: context.screenWidth * 0.16,
              // height: context.screenHeight * 0.16,
              constraints: const BoxConstraints(minWidth: 50),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSizes.smallBorderRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.smallPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Icon(
                        icon,
                        color: Color(item.color),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(
                        height: 4,
                      ),
                    ),
                    CustomText.bodySmall(
                      item.name,
                      maxLines: 1,
                      customStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
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
