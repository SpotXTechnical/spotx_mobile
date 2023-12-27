import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:owner/utils/analytics/i_analytics.dart';

class FireBaseAnalyticsImplementation extends IAnalytics {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // final FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  @override
  Future<void> logEvent({required String name, Map<String, dynamic>? parameters}) {
    return analytics.logEvent(name: name, parameters: parameters);
  }

  @override
  Future<void> setUserId(String id) {
    // crashlytics.setUserIdentifier(id);
    return analytics.setUserId();
  }

  @override
  Future<void> setUserProperty({required String name, required String value}) {
    // crashlytics.setCustomKey(name, value);
    return analytics.setUserProperty(name: name, value: value);
  }

}