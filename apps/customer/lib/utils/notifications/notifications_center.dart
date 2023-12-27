// global handling for all types of notifications [for ground, background, ...]
import 'package:spotx/presentation/main/screens/home/screens/unit_details/model/unit_details_screen_nav_args.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/pending/reservation_details_pending_screen.dart';
import 'package:spotx/presentation/owner_profile/owner_profile_screen.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:flutter/foundation.dart';

void handleNotification(Map<String, dynamic> intent) {
  debugPrint("intent");

  switch (intent['resource']) {
    case 'reservation':
      {
        debugPrint('reservation : ${intent['id']}');
        navigationKey.currentState?.pushNamed(ReservationDetailsPendingScreen.tag, arguments: intent['id']);
      }
      break;
    case 'owner':
      {
        debugPrint('owner : ${intent['id']}');
        navigationKey.currentState?.pushNamed(OwnerProfileScreen.tag, arguments: [intent['id']]);
      }
      break;
    case 'unit':
      {
        debugPrint('unit : ${intent['id']}');
        navigationKey.currentState?.pushNamed(UnitDetailsScreen.tag,
            arguments: UnitDetailsScreenNavArgs(intent['id'].toString(), UnitDetailsScreenType.normalUnit));
      }
  }
}

enum NotificationResource {
  reservation,
  owner,
  unit,
}