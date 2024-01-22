import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<String> initDeviceInfoPlugin() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      return info.androidId!;
    } else if (Platform.isIOS) {
      IosDeviceInfo info = await deviceInfoPlugin.iosInfo;
      return info.identifierForVendor!;
    } else {
      return '';
    }
  } on PlatformException catch (e) {
    Fluttertoast.showToast(msg: e.message.toString());
    return '';
  }
}