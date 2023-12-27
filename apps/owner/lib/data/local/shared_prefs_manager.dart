import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    return;
  }

  SharedPreferences? prefs;

  String get locale {
    return prefs?.getString(appSavedLocaleKey) ?? "";
  }

  set locale(String savedLocale) {
    prefs?.setString(appSavedLocaleKey, savedLocale);
  }

  LoginResponseEntity? get credentials {
    var loginString = prefs?.getString(appLoginCredentialsKey) ?? "";
    if (loginString.isNotEmpty) {
      return LoginResponseEntity.fromJson(json.decode(loginString));
    } else {
      return null;
    }
  }

  set credentials(LoginResponseEntity? loginResponseEntity) {
    prefs?.setString(appLoginCredentialsKey, (loginResponseEntity != null) ? json.encode(loginResponseEntity.toJson()) : "");
  }

  String get subDomain {
    return prefs?.getString(subDomainKey) ?? "";
  }

  set subDomain(String subDomain) {
    prefs?.setString(subDomainKey, subDomain);
  }

  String get firebaseToken {
    return prefs?.getString(firebaseTokenKey) ?? "";
  }

  set firebaseToken(String token) {
    prefs?.setString(firebaseTokenKey, token);
  }

  String? get accessToken {
    return credentials?.token?.accessToken;
  }

  String get theme {
    return prefs?.getString(appSavedThemeKey) ?? "";
  }

  set theme(String savedTheme) {
    prefs?.setString(appSavedThemeKey, savedTheme);
  }
}

Future<bool> isLoggedInBefore() async {
  var loggedInCredentials = Injector().get<SharedPrefsManager>().credentials;
  debugPrint("logged in user: ${loggedInCredentials?.user?.name ?? ""}");
  debugPrint("is logged in before: ${loggedInCredentials != null}");
  return loggedInCredentials != null;
}

const String appSavedLocaleKey = 'appSavedLocaleKey';
const String appSavedThemeKey = 'appSavedThemeKey';
const String appLoginCredentialsKey = "appLoginCredentialsKey";
const String subDomainKey = "subDomainKey";
const String firebaseTokenKey = "firebaseToken";