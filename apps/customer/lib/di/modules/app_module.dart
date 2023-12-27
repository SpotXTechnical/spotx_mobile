import 'package:spotx/data/local/shared_prefs_manager.dart';
import 'package:spotx/utils/analytics/firebase_analytics_implementation.dart';
import 'package:spotx/utils/analytics/i_analytics.dart';
import 'package:spotx/utils/network/network_manager.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class AppModule {
  Future<Injector> initialise(Injector injector) async{
    injector.map<NetworkManager>((i) => NetworkManager(), isSingleton: true);
    final SharedPrefsManager sharedPrefsManager = SharedPrefsManager();
    await sharedPrefsManager.init();
    injector.map<SharedPrefsManager>((i) => sharedPrefsManager, isSingleton: true);
    injector.map<IAnalytics>((i) => FireBaseAnalyticsImplementation(), isSingleton: true);
    return injector;
  }
}