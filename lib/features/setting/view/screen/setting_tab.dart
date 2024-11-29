import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:locate_me/core/navigation/routes.dart';
import 'package:locate_me/core/widget/custom_text.dart';

import 'package:locate_me/features/setting/view/widgets/items/import.dart';

import 'package:locate_me/generated/locale_keys.g.dart';

import '../../../../core/widget/ads_widget.dart';

import '../../../../core/widget/loading.dart';
import '../../model/dto/setting_item_dto.dart';
import '../../provider/settings_provider.dart';
import '../widgets/items/export.dart';
import '../widgets/items/language.dart';
import '../widgets/items/map.dart';
import '../widgets/items/theme.dart';
import '../widgets/items/update_passworrd.dart';

class SettingsTab extends ConsumerStatefulWidget {
  const SettingsTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingTabState();
}

class _SettingTabState extends ConsumerState<SettingsTab> {
  late final TextEditingController _fileName = TextEditingController();
  late final TextEditingController _password = TextEditingController();
  late final TextEditingController _repeatPassword = TextEditingController();

  List<SettingItemDto> get settingsItems => [
        SettingItemDto(
          title: LocaleKeys.language.tr(),
          icon: FontAwesomeIcons.language,
          onTap: (context) => showLanguageModal(context),
        ),
        SettingItemDto(
          title: LocaleKeys.theme.tr(),
          icon: FontAwesomeIcons.paintRoller,
          onTap: (context) => showThemeModal(context),
        ),
        SettingItemDto(
          title: LocaleKeys.map_settings.tr(),
          icon: FontAwesomeIcons.map,
          onTap: (context) => showMapSettingsModal(context),
        ),
        SettingItemDto(
          title: LocaleKeys.export.tr(),
          icon: FontAwesomeIcons.upload,
          onTap: (p0) async {
            await showExportModal(context, _fileName).then((_) {
              _fileName.clear();
            });
          },
        ),
        SettingItemDto(
            title: LocaleKeys.import.tr(),
            icon: FontAwesomeIcons.download,
            onTap: (context) async {
              ref.read(importNotifierProvider.notifier).importData();
              await showImportModal(context);
            }),
        SettingItemDto(
            title: LocaleKeys.categories.tr(),
            icon: FontAwesomeIcons.list,
            onTap: (context) async {
              context.pushNamed(Routes.categoryList);
            }),
        SettingItemDto(
            title: LocaleKeys.change_Password.tr(),
            icon: FontAwesomeIcons.key,
            onTap: (context) async {
              await showChangePasswordModal(context, _password, _repeatPassword)
                  .then((_) {
                _password.clear();
                _repeatPassword.clear();
              });
            }),
        SettingItemDto(
          title: '${LocaleKeys.signIn.tr()} ${LocaleKeys.auto.tr()}',
        )
      ];

  @override
  void dispose() {
    _fileName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext rootContext) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        // elevation: 4,
        toolbarHeight: 60,

        title: Center(
            child: CustomText.headlineSmall(
          LocaleKeys.settings.tr(),
          customStyle:
              TextStyle(color: Theme.of(context).colorScheme.onSurface),
        )),
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: settingsItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 3 / 2,
              ),
              itemBuilder: (context, index) {
                final item = settingsItems[index];
                return Card(
                  color: Theme.of(rootContext).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 4.0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.0),
                    onTap: () async {
                      if (item.onTap != null) {
                        item.onTap!(context);
                      } else {
                        await ref
                            .read(autoLoginNotifierProvider.notifier)
                            .updateAutoLoginState();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (item.icon == null)
                            SizedBox(
                              height: 30,
                              child: ref.watch(autoLoginNotifierProvider).when(
                                  data: (data) {
                                    log('message: $data');
                                    return Switch.adaptive(
                                      value: data,
                                      onChanged: (value) async {
                                        await ref
                                            .read(autoLoginNotifierProvider
                                                .notifier)
                                            .updateAutoLoginState();
                                      },
                                    );
                                  },
                                  error: (error, stackTrace) => const MyLoading(
                                        size: 10,
                                      ),
                                  loading: () => const MyLoading(
                                        size: 10,
                                      )),
                            ),
                          if (item.icon != null)
                            FaIcon(
                              item.icon,
                              color: Theme.of(context).colorScheme.primary,
                              size: 30.0,
                            ),
                          const SizedBox(height: 16.0),
                          CustomText.bodySmall(item.title),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AdsWidget(),
          )
        ],
      ),
    );
  }
}
