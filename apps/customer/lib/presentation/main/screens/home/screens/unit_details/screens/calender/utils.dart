import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/presentation/main/main_screen.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/pending/reservation_details_pending_screen.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';

void navigateToReservationDetailsScreen(int id) {
  RouteSettings settings = const RouteSettings(arguments: 2); //reservation index
  MaterialPageRoute route = MaterialPageRoute(builder: (context) => const MainScreen(), settings: settings);
  navigationKey.currentState?.pushAndRemoveUntil(route, (r) => false);
  route.didPush().whenComplete(() {
    navigationKey.currentState?.pushNamed(ReservationDetailsPendingScreen.tag, arguments: id.toString());
  });
}
