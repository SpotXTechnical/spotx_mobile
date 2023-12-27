import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:owner/base/base_service.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class UpdateFireBaseTokenService extends BaseService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  updateFirebaseToken() async {
    _firebaseMessaging.getToken().then((token) async {
      debugPrint("FCM token: " + (token ?? ''));
      Map<String, dynamic> data = {"provider": "firebase", "token": token, "device": "mobile"};
      NetworkRequest request =
          NetworkRequest(deviceTokenApi, RequestMethod.post, headers: await getHeaders(), data: FormData.fromMap(data));
      await networkManager.perform(request);
    });
  }
}