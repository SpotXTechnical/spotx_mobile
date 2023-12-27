import 'package:firebase_remote_config/firebase_remote_config.dart';

final remoteConfig = FirebaseRemoteConfig.instance;

initRemoteConfig() async {
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));
}

bool getRCBool({required String key}) {
  return remoteConfig.getBool(key);
}

abstract class RemoteConfigKeys {
  static const String showNationalIdentity = "showNationalIdentity";
}