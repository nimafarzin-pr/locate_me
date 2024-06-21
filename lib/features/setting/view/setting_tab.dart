import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:locate_me/core/widget/custom_text.dart';

import 'package:locate_me/generated/locale_keys.g.dart';

import '../model/dto/setting_item_dto.dart';
import '../provider/export_import_notifier.dart';
import 'widgets/items/export.dart';
import 'widgets/items/language.dart';
import 'widgets/items/map.dart';
import 'widgets/items/theme.dart';

class SettingsTab extends ConsumerStatefulWidget {
  const SettingsTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingTabState();
}

class _SettingTabState extends ConsumerState<SettingsTab> {
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
          onTap: (p0) {
            ref.read(exportAndImportNotifierProvider.notifier).exportData();
          },
        ),
        SettingItemDto(
          title: LocaleKeys.import.tr(),
          icon: FontAwesomeIcons.download,
          onTap: (context) => showExportDialog(context),
        ),
      ];

  @override
  Widget build(BuildContext rootContext) {
    return Scaffold(
      appBar: AppBar(
          // elevation: 2,
          // backgroundColor: Theme.of(context).colorScheme.surface,
          title: CustomText.headlineMedium(LocaleKeys.settings.tr())),
      body: ListView.builder(
        itemCount: settingsItems.length,
        itemBuilder: (context, index) {
          final item = settingsItems[index];
          return Card(
            color: Theme.of(rootContext).colorScheme.surfaceContainer,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: FaIcon(item.icon,
                  color: Theme.of(context).colorScheme.primary),
              title: CustomText.bodyLarge(item.title),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary, size: 16),
              onTap: () => item.onTap(context),
            ),
          );
        },
      ),
    );
  }
}
