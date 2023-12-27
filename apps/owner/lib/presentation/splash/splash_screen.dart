import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:owner/data/remote/auth/auth_repository.dart';
import 'package:owner/presentation/splash/bloc/splash_bloc.dart';
import 'package:owner/presentation/splash/bloc/splash_event.dart';
import 'package:owner/presentation/splash/bloc/splash_state.dart';
import 'package:owner/utils/force_update.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/notifications/notifications_center.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const tag = "SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    handleAppOpenedFromNotification();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (ctx) => SplashBloc(authRepository: AuthRepository())..add(CheckForceUpdate()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (ctx, state) {
          if (state is ForceUpdate) {
            showVersionDialog();
          }
        },
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      splashScreenPath,
                    ),
                    fit: BoxFit.cover)),
          ),
        ),
      ),
    );
  }

  void handleAppOpenedFromNotification() async {
    //  handle app received message while was terminated
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        handleNotification(message.data);
      }
    });

    // handle app opened from local notifications plugin
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails != null &&
        notificationAppLaunchDetails.didNotificationLaunchApp &&
        notificationAppLaunchDetails.notificationResponse?.payload != null) {
      handleNotification(json.decode(notificationAppLaunchDetails.notificationResponse?.payload ?? '') as Map<String, dynamic>);
    }
  }
}