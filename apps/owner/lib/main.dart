import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/app_observer.dart';
import 'package:owner/di/modules/app_module.dart';
import 'package:owner/presentation/splash/splash_screen.dart';
import 'package:owner/utils/analytics/analytics_screen_mapper.dart';
import 'package:owner/utils/analytics/crashylytics.dart';
import 'package:owner/utils/const.dart';
import 'package:owner/utils/deep_link_utils.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/notifications/local_notifications.dart';
import 'package:owner/utils/notifications/push_notifications.dart';
import 'package:owner/utils/remote_config/remote_config.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';

runSpotXApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppModule().initialise(Injector()); // initialize simple dependency injector
  Bloc.observer = AppObserver();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await initDeepLinking();
  setUpCrashlytics();
  initPushNotifications();
  initLocalNotification();
  initRemoteConfig();
  if (kReleaseMode) {
    // this should skip printing in release mode
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  runApp(EasyLocalization(
    path: 'assets/translations',
    supportedLocales: localeList,
    fallbackLocale: englishLocale,
    useOnlyLangCode: true,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child ?? Container(),
        );
      },      title: 'SpotX Owner',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: getDarkTheme(),
      darkTheme: getDarkTheme(),
      navigatorKey: navigationKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: getApplicationRoute,
      initialRoute: SplashScreen.tag,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance, nameExtractor: analyticsScreenMapper),
      ],
    );
  }
}