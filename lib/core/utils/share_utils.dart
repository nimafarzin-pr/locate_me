import 'dart:io';

import 'package:flutter/material.dart';
import 'package:locate_me/core/extension/screen_size_extension.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/dialogs/diolog_wrapper.dart';

class ShareUtils {
  static Future<void> shareLocation({
    required String markerLabel,
    required BuildContext context,
    required double lat,
    required double lng,
  }) async {
    try {
      if (Platform.isAndroid) {
        final url = Uri.parse('geo:$lat,$lng?q=$lat,$lng($markerLabel)');
        await launchUrl(url);
      } else {
        final availableMaps = await MapLauncher.installedMaps;
        await showDialog(
          context: context,
          builder: (dContext) {
            return Padding(
              padding: const EdgeInsets.all(40),
              child: DialogWrapper(
                height: context.screenWidth / 2,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: availableMaps.length,
                  itemBuilder: (context, index) {
                    final maps = availableMaps[index];

                    return Column(
                      children: [
                        Column(
                          children: [
                            TextButton(
                              onPressed: () async {
                                await maps.showMarker(
                                  coords: Coords(lat, lng),
                                  title: markerLabel,
                                );

                                Navigator.pop(dContext);
                              },
                              child: Text(maps.mapName.toString()),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      }
    } catch (error) {}
  }
}
