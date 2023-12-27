import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void initLocalNotification() async {
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/launcher_icon');
  final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {});

  final DarwinInitializationSettings initializationSettingsMacOS = DarwinInitializationSettings();

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings, /*onSelectNotification: (String? payLoad) {
    debugPrint("local notification: $payLoad");
    handleNotification(json.decode(payLoad ?? ''));
  }*/);
}

Future<void> showLocalNotification(RemoteMessage message) async {
  debugPrint("show local notification, message: $message");
   //debugPrint("show local notification, encoded message: ${json.encode(message.notification)}");
  const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    omnifulChannelId,
    omnifulChannelName,
    channelDescription: omnifulChannelDescription,
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, message.notification?.title, message.notification?.body, platformChannelSpecifics,
      payload: json.encode(message.data));
}

const omnifulChannelId = "omniful channel id";
const omnifulChannelName = "Omniful";
const omnifulChannelDescription = "orders availability";