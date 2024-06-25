import 'dart:io';

import 'package:intl/intl.dart';
import 'package:locate_me/core/utils/date_converter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsUtils {
  // static Future<bool> requestStoragePermission() async {
  //   bool permissionGranted = false;
  //   DeviceInfoPlugin plugin = DeviceInfoPlugin();
  //   AndroidDeviceInfo android = await plugin.androidInfo;
  //   if (android.version.sdkInt < 33) {
  //     if (await Permission.storage.request().isGranted) {
  //       permissionGranted = true;
  //     } else if (await Permission.storage.request().isPermanentlyDenied) {
  //       await openAppSettings();
  //     } else if (await Permission.audio.request().isDenied) {
  //       permissionGranted = false;
  //     }
  //   } else {
  //     if (await Permission.photos.request().isGranted) {
  //       permissionGranted = true;
  //     } else if (await Permission.photos.request().isPermanentlyDenied) {
  //       await openAppSettings();
  //     } else if (await Permission.photos.request().isDenied) {
  //       permissionGranted = false;
  //     }
  //   }
  //   return permissionGranted;
  // }

  static Future<String?> getDownloadDirectory() async {
    final bool isStoragePermitted =
        await storagePermissionStatus() || await checkStoragePermission();
    if (isStoragePermitted) {
      return await _getBackupPath();
    }
    return null;
  }

  static Future<String> _getBackupPath() async {
    Directory? directory;
    final mainDirectory = await getExternalStorageDirectory();
    directory = Directory('/storage/emulated/0/Download/LocateMe/');
    final format = mainDirectory?.path.replaceFirst('/', '');
    final customFormat = format?.replaceFirst('0', '!');
    final sp = customFormat?.split("!");
    final path = '${sp?[0]}0/Download/LocateMe/';
    if (!await directory.exists()) {
      directory = await Directory(path).create(recursive: true);
    } else {
      directory = Directory(path);
    }
    return directory.path;
  }

  // create file path for read or write
  static Future<File> createFilePath({required String fileName}) async {
    DateTime today = DateTime.now();
    final dateFormat = DateConverter.autoConverter(today.toIso8601String());
    final root = await _getBackupPath();
    return File("/$root/$fileName.txt");
  }

  static Future<bool> checkStoragePermission() async {
    // if (Platform.isIOS) {
    //   await Permission.storage.request();
    //   await Permission.storage.status;
    //   await Permission.photos.request();
    //   await Permission.photos.status;
    //   return true;
    // }

    final AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    final int androidSdk = androidInfo.version.sdkInt;

    if (androidSdk <= 29) {
      final storage = await Permission.storage.request();
      if (storage.name == "permanentlyDenied") await openAppSettings();

      return storage.isGranted;
    }
    return true;
  }

  static Future<bool> storagePermissionStatus() async {
    // if (Platform.isIOS) {
    //   return (await Permission.photos.status.isGranted ||
    //       await Permission.storage.status.isGranted);
    // }

    final AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    final int androidSdk = androidInfo.version.sdkInt;

    return androidSdk <= 29 ? await Permission.storage.isGranted : true;
  }
}
