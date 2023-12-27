import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spotx/data/local/shared_prefs_manager.dart';
import 'package:spotx/utils/network/network_manager.dart';
import 'package:spotx/utils/utils.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class BaseService {
  final SharedPrefsManager sharedPrefsManager = Injector().get<SharedPrefsManager>();
  final NetworkManager networkManager = Injector().get<NetworkManager>();

  Future<Map<String, String>> getHeaders() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    debugPrint('packageInfo buildNumber: ${packageInfo.buildNumber}');
    debugPrint('packageInfo version: ${packageInfo.version}');
    return {
      "Accept": "application/json",
      "Content-Type": "multipart/form-data",
      "Accept-Language": isArabic ? 'ar' : 'en',
      "Authorization": "Bearer ${sharedPrefsManager.accessToken ?? ''}",
      'app-type' : 'client',
      'os': await platform,
      'version': packageInfo.buildNumber,
    };
  }

  Future<String> get platform async {
    if (Platform.isIOS) {
      return 'ios';
    } else if (Platform.isAndroid) {
      if (await isHuaweiDevice()) {
        return 'huawei';
      } else {
        return 'android';
      }
    } else {
      return 'unsupported';
    }
  }
}

const String huawei = 'huawei';
const String android = 'android';
const String ios = 'ios';
