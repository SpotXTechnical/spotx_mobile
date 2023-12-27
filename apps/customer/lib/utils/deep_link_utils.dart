import 'dart:convert';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:spotx/data/remote/unit/model/filter_queryies.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/search_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/sub_region/sub_region_details_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/model/unit_details_screen_nav_args.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:spotx/presentation/main/screens/profile/profile_screen.dart';
import 'package:spotx/presentation/owner_profile/owner_profile_screen.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/foundation.dart';

const dataKey = "data";

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

handleDynamicLink(Map<String, String> queryParameters) async {
  String? id = queryParameters[DynamicLinksKeys.id];
  String? target = queryParameters[DynamicLinksKeys.target];
  String? data = queryParameters[dataKey];
  if (id != null) {
    debugPrint("target= $target");
    switch (target) {
      case DynamicLinksTargets.unit:
        debugPrint("target= mahmoud");
        Future.delayed(const Duration(seconds: 1), () {
          navigationKey.currentState?.pushNamed(UnitDetailsScreen.tag,
              arguments: UnitDetailsScreenNavArgs(
                id.toString(),
                UnitDetailsScreenType.normalUnit,
              ));
        });
        break;
      case DynamicLinksTargets.owner:
        Future.delayed(const Duration(seconds: 1), () {
          navigationKey.currentState?.pushNamed(
            OwnerProfileScreen.tag,
            arguments: [id.toString()],
          );
        });
        break;

      case DynamicLinksTargets.subRegion:
        Future.delayed(const Duration(seconds: 1), () {
          navigationKey.currentState?.pushNamed(
            SubRegionDetailsScreen.tag,
            arguments: int.parse(id.toString()),
          );
        });
        break;
      case DynamicLinksTargets.searchResult:
        if (data != null) {
          Future.delayed(const Duration(seconds: 1), () {
            navigationKey.currentState?.pushNamed(
              SearchScreen.tag,
              arguments: FilterQueries.fromJson(jsonDecode(data)),
            );
          });
        }
        break;
      default:
        navigationKey.currentState?.pushNamed(ProfileScreen.tag);
        break;
    }
  }
}

Future<void> createDynamicLink(String id, String target, [String? data]) async {
  String dynamicLink = 'https://spotx.app?${DynamicLinksKeys.id}=$id&${DynamicLinksKeys.target}=$target&$dataKey=$data';
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://spotx.page.link',
    link: Uri.parse(dynamicLink),
    androidParameters: const AndroidParameters(
      packageName: 'com.spotx.customer',
      minimumVersion: 1,
    ),
    iosParameters: const IOSParameters(
      bundleId: "com.spotx.customerApp",
      appStoreId: '6444921625', // using this app should navigate to app store if app not installed, in case didn't work try to use the isi parameter 'https://firebase.google.com/docs/dynamic-links/create-manually'
    ),
  );
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  Uri uri;
  try {
     final link = await dynamicLinks.buildShortLink(parameters);
     uri = link.shortUrl;
  } catch (e){
    uri = parameters.link;
  }
  Share.share(uri.toString());
}

abstract class DynamicLinksKeys {
  static const id = "idKey";
  static const target = "targetKey";
}

abstract class DynamicLinksTargets {
  static const unit = "unit";
  static const reservation = "reservation";
  static const owner = "owner";
  static const subRegion = "subRegion";
  static const searchResult = "search";
}