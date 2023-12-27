import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:owner/utils/notifications/local_notifications.dart';

// https://github.com/FirebaseExtended/flutterfire/issues/2387#issuecomment-648307837
// follow this link to handle background data FCM

void initPushNotifications() async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  //  listen to messages whilst your application is in the foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');
    debugPrint("onMessage: $message");
    AndroidNotification? android = message.notification?.android;
    if (android != null) {
      showLocalNotification(message);
    }
    if (message.notification != null) {
      debugPrint('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

  // // handle notification here while app opened from notifications and was not terminated
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   handleNotification(message.data);
  // });

  // require notifications permissions for ios users
  NotificationSettings settings = await _firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    debugPrint('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    debugPrint('User granted provisional permission');
  } else {
    debugPrint('User declined or has not accepted permission');
  }
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  _firebaseMessaging.getToken().then((token) async {
    debugPrint("FCM token: " + (token ?? ''));
  });
}

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  debugPrint("inside back ground handler");
}