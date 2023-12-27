import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/app_observer.dart';
import 'package:spotx/di/modules/app_module.dart';
import 'package:spotx/presentation/splash/splash_screen.dart';
import 'package:spotx/utils/analytics/analytics_screen_mapper.dart';
import 'package:spotx/utils/analytics/crashylytics.dart';
import 'package:spotx/utils/const.dart';
import 'package:spotx/utils/deep_link_utils.dart';
import 'package:spotx/utils/logger.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/notifications/local_notifications.dart';
import 'package:spotx/utils/notifications/push_notifications.dart';
import 'package:spotx/utils/style/theme.dart';
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
  setupLogger();
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
      },
      title: 'SpotX',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: getDarkTheme(),
      darkTheme: getDarkTheme(),
      navigatorKey: navigationKey,
      onGenerateRoute: getApplicationRoute,
      initialRoute: SplashScreen.tag,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance, nameExtractor: analyticsScreenMapper),
      ],
    );
  }
}