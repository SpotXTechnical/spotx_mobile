import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:share_plus/share_plus.dart';

initDeepLinking() async {
  debugPrint('initializing deep link');
  try {
    // Get any initial links
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    // handle deep link while application is open or in background
    dynamicLinks.onLink.listen((dynamicLinkData) {
      handleDynamicLink(dynamicLinkData.link.queryParameters);
    }).onError((error) {
      // Handle errors
      debugPrint("deeplink error: $error");
    });
  } catch (e) {
    debugPrint('deeplink error:$e');
  }
}

handleDynamicLink(Map<String, String> queryParameters) {
  String? id = queryParameters[DynamicLinksKeys.id];
  String? target = queryParameters[DynamicLinksKeys.target];
  switch (target) {
    case DynamicLinksTargets.unit:
      navigationKey.currentState?.pushNamed(UnitDetailsScreen.tag, arguments: id);
      break;
  }
}

Future<void> createDynamicLink(String id, String target) async {
  String dynamicLink = 'https://spotx.app?${DynamicLinksKeys.id}=$id&${DynamicLinksKeys.target}=$target';
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://spotx.page.link',
    link: Uri.parse(dynamicLink),
    androidParameters: const AndroidParameters(
      packageName: 'com.spotx.customer',
      minimumVersion: 1,
    ),
    iosParameters: const IOSParameters(
      bundleId: "com.spotx.customerApp",
      appStoreId: '6444921625'
    ),
  );
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  final ShortDynamicLink uri = await dynamicLinks.buildShortLink(parameters);
  Share.share(uri.shortUrl.toString());
}
abstract class DynamicLinksKeys {
  static const id = "idKey";
  static const target = "targetKey";
}
abstract class DynamicLinksTargets {
  static const unit = "unit";
  static const reservation = "reservation";
  static const owner = "owner";
}