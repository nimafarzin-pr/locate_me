import 'package:flutter/material.dart';
import 'package:locate_me/core/widget/custom_text.dart';

import '../model/dto/setting_item_dto.dart';
import 'widgets/export_import.dart';
import 'widgets/language.dart';
import 'widgets/map.dart';
import 'widgets/theme.dart';

class SettingsTab extends StatelessWidget {
  List<SettingItemDto> get settingsItems => [
        SettingItemDto(
          title: 'Language',
          icon: Icons.language,
          page: const LanguagePage(),
        ),
        SettingItemDto(
          title: 'Theme',
          icon: Icons.color_lens,
          page: const ThemePage(),
        ),
        SettingItemDto(
          title: 'Map Settings',
          icon: Icons.map,
          page: const MapSettingsPage(),
        ),
        SettingItemDto(
          title: 'Export/Import Data',
          icon: Icons.import_export,
          page: const ExportImportDataPage(),
        ),
      ];

  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText.headlineMedium('Settings')),
      body: ListView.builder(
        itemCount: settingsItems.length,
        itemBuilder: (context, index) {
          final item = settingsItems[index];
          return ListTile(
            leading: Icon(item.icon),
            title: CustomText.bodyLarge(item.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => item.page),
              );
            },
          );
        },
      ),
    );
  }
}
