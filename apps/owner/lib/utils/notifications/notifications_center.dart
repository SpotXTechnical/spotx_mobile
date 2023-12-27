// global handling for all types of notifications [for ground, background, ...]
import 'package:flutter/foundation.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/reservation_details/reservation_details_screen.dart';

import '../navigation/navigation_helper.dart';

void handleNotification(Map<String, dynamic> intent) {
  debugPrint("intent");
  switch (intent['resource']) {
    case 'reservation':
      {
        debugPrint('reservation : ${intent['id']}');
        navigationKey.currentState?.pushNamed(ReservationDetailsScreen.tag, arguments: intent['id']);
      }
      break;
    case 'unit':
      {
        debugPrint('unit : ${intent['id']}');
        navigationKey.currentState?.pushNamed(UnitDetailsScreen.tag, arguments: intent['id']);
      }
  }
}

enum NotificationResource {
  reservation,
  owner,
  unit,
}