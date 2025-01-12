import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  Future<String> getDeviceDetails() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return 'Android: ${androidInfo.model}, ${androidInfo.manufacturer}';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return 'iOS: ${iosInfo.utsname.machine}, ${iosInfo.systemName}';
      } else {
        return "Unsupported platform";
      }
    } catch (e) {
      return "Unknown device";
    }
  }
}
