import 'dart:io';
import 'package:flutter/material.dart';
import 'package:owner/data/local/shared_prefs_manager.dart';
import 'package:owner/utils/network/network_manager.dart';
import 'package:owner/utils/utils.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
      'app-type' : 'owner',
      'os': await platform,
      'version': packageInfo.buildNumber,
      "Authorization": "Bearer ${sharedPrefsManager.accessToken}"
    };
  }

  Future<String> get platform async {
    if (Platform.isIOS) {
      return 'ios';
    } else if (Platform.isAndroid) {
      return 'android';
    } else {
      return 'unsupported';
    }
  }
}

const String huawei = 'huawei';
const String android = 'android';
const String ios = 'ios';
