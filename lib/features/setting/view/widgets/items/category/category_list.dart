import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/utils/icon_picker_utils.dart';
import 'package:locate_me/core/widget/custom_back_icon.dart';
import 'package:locate_me/core/widget/custom_text.dart';
import 'package:locate_me/core/widget/dialogs/status_widget.dart';
import 'package:locate_me/core/widget/empty_box.dart';
import 'package:locate_me/core/widget/animation/fade_in_scale_animation.dart';
import 'package:locate_me/core/widget/loading.dart';
import 'package:locate_me/features/setting/view/widgets/items/category/add_category_view.dart';

import '../../../../../../core/common_features/category/provider/category_provider.dart';
import '../../../../../../core/widget/dialogs/warning_dialog.dart';
import '../../../../../../generated/locale_keys.g.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: () async {
        context.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          centerTitle: true,
          leading: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.surface,
              elevation: 0,
              onPressed: () {
                context.pop();
              },
              child: const CustomBackIcon()),
          actions: [
            IconButton(
                iconSize: 20,
                onPressed: () async {
                  await showAddCategoryModal(context);
                },
                icon: const FaIcon(FontAwesomeIcons.plus))
          ],
          title: CustomText.headlineSmall(LocaleKeys.category_list.tr()),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final data = ref.watch(categoryNotifierProvider);
                  return data.when(
                      data: (data) {
                        if (data.isEmpty) {
                          return const Center(child: EmptyBox());
                        }
                        return ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            indent: 20,
                            endIndent: 20,
                            thickness: 0.2,
                            color: Colors.grey[400],
                          ),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            log('$data');
                            final item = data[index];
                            final icon = IconPickerUtils.iconPickerDeserializer(
                                item.iconString);

                            return FadeInScaleAnimation(
                              child: ListTile(
                                trailing: IconButton(
                                  onPressed: () {
                                    showWarningDialog(
                                      context: context,
                                      content: LocaleKeys
                                          .do_you_want_to_continue
                                          .tr(),
                                      iconColor:
                                          Theme.of(context).colorScheme.error,
                                      title:
                                          '${LocaleKeys.delete.tr()} ${item.name}',
                                      onConfirm: () async {
                                        ref
                                            .read(categoryNotifierProvider
                                                .notifier)
                                            .deleteCategory(item.id!);
                                      },
                                    );
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.trashCan,
                                    size: 20,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                                title: Text(
                                  item.name == 'all'
                                      ? LocaleKeys.all.tr()
                                      : item.name,
                                ),
                                leading: CircleAvatar(
                                  radius: 27,
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.2),
                                  child: CircleAvatar(
                                      radius: 26,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.surface,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: icon != null
                                            ? Icon(
                                                icon.data,
                                                color: Color(item.color),
                                              )
                                            //  Text(
                                            //     'Database Entry:\n${serializeIcon(icon, iconPack: IconPack.allMaterial).toString()}',
                                            //   )
                                            : CustomText.headlineSmall(
                                                item.iconString),
                                      )),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      error: (error, stackTrace) {
                        return StatusWidget(
                          title: LocaleKeys.error.tr(),
                          content: "$error",
                          disableButtons: true,
                          iconColor: Theme.of(context).colorScheme.error,
                        );
                      },
                      loading: () => const MyLoading());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
