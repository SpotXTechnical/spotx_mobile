import 'package:flutter/material.dart';
import 'package:owner/presentation/auth/login/login_screen.dart';
import 'package:owner/presentation/auth/register/register_screen.dart';
import 'package:owner/presentation/common/media_pager/media_pager_screen.dart';
import 'package:owner/presentation/main/main_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/choose_unit_type_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/add_camp_first/add_camp_first_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/add_camp_second/add_camp_second_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/add_camp_thrid/add_camp_third_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/camp/room/add_room_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_four/add_unit_fourth_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_one/add_unit_first_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/add_unit_third_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/sub_regions_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_two/add_unit_second_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/special_price/add_special_price_screen.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/special_price/screens/calender/calender_screen.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_first_screen/edit_unit_first_screen.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_fourth_screen/edit_unit_fourth_screen.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_second_screen/edit_unit_second_screen.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_third_screen/edit_unit_third_screen.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/special_price/edit_special_price_screen.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/special_price/screens/calender/edit_calender_screen.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/add_reservation_screen/add_reservation_screen.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/reservation_details/reservation_details_screen.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/select_unit/select_unit_screen.dart';
import 'package:owner/presentation/main/screens/statistics/screens/filter/filter_screen.dart';
import 'package:owner/presentation/main/screens/statistics/screens/send_notification/send_notification_screen.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_contacts/statistics_contacts_screen.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/screens/add_payment/add_payment_screen.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/statistics_details_screen.dart';
import 'package:owner/presentation/splash/splash_screen.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

Route getApplicationRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.tag:
      return _buildRoute(settings, const SplashScreen());

    case LoginScreen.tag:
      return _buildRoute(settings, const LoginScreen());

    case RegisterScreen.tag:
      return _buildRoute(settings, const RegisterScreen());

    case AddUnitFirstScreen.tag:
      return _buildRoute(settings, const AddUnitFirstScreen());

    case AddUnitSecondScreen.tag:
      return _buildRoute(settings, const AddUnitSecondScreen());

    case AddUnitThirdScreen.tag:
      return _buildRoute(settings, AddUnitThirdScreen());

    case AddSpecialPriceScreen.tag:
      return _buildRoute(settings, const AddSpecialPriceScreen());

    case CalenderScreen.tag:
      return _buildRoute(settings, const CalenderScreen());

    case AddUnitFourthScreen.tag:
      return _buildRoute(settings, const AddUnitFourthScreen());

    case MainScreen.tag:
      return _buildRoute(settings, const MainScreen());

    case ChooseUnitTypeScreen.tag:
      return _buildRoute(settings, const ChooseUnitTypeScreen());

    case AddRoomScreen.tag:
      return _buildRoute(settings, const AddRoomScreen());

    case AddCampThirdScreen.tag:
      return _buildRoute(settings, const AddCampThirdScreen());

    case AddCampFirstScreen.tag:
      return _buildRoute(settings, const AddCampFirstScreen());

    case AddCampSecondScreen.tag:
      return _buildRoute(settings, const AddCampSecondScreen());

    case StatisticsDetailsScreen.tag:
      return _buildRoute(settings, const StatisticsDetailsScreen());

    case AddPaymentScreen.tag:
      return _buildRoute(settings, const AddPaymentScreen());

    case StatisticsContactsScreen.tag:
      return _buildRoute(settings, const StatisticsContactsScreen());

    case SendNotificationScreen.tag:
      return _buildRoute(settings, const SendNotificationScreen());

    case FilterScreen.tag:
      return _buildRoute(settings, const FilterScreen());

    case AddReservationScreen.tag:
      return _buildRoute(settings, const AddReservationScreen());

    case UnitDetailsScreen.tag:
      return _buildRoute(settings, const UnitDetailsScreen());

    case ReservationDetailsScreen.tag:
      return _buildRoute(settings, const ReservationDetailsScreen());

    case SelectUnitScreen.tag:
      return _buildRoute(settings, const SelectUnitScreen());

    case SubRegionsScreen.tag:
      return _buildRoute(settings, const SubRegionsScreen());

    case EditUnitFirstScreen.tag:
      return _buildRoute(settings, const EditUnitFirstScreen());

    case EditUnitSecondScreen.tag:
      return _buildRoute(settings, const EditUnitSecondScreen());

    case EditUnitThirdScreen.tag:
      return _buildRoute(settings, EditUnitThirdScreen());

    case EditUnitFourthScreen.tag:
      return _buildRoute(settings, const EditUnitFourthScreen());

    case EditSpecialPriceScreen.tag:
      return _buildRoute(settings, EditSpecialPriceScreen());

    case EditCalenderScreen.tag:
      return _buildRoute(settings, const EditCalenderScreen());

    case MediaPagerScreen.tag:
      return _buildRoute(settings, const MediaPagerScreen());

    default:
      throw Exception("un registered route");
  }
}

PageRouteBuilder _buildRoute(RouteSettings settings, Widget page,
    {int transitionTime = 400, Offset transitionBegin = Offset.zero}) {
  return PageRouteBuilder(
      settings: settings,
      transitionDuration: Duration(milliseconds: transitionTime),
      pageBuilder: (BuildContext context, _, __) => page,
      transitionsBuilder: (_, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: transitionBegin,
              end: Offset.zero,
            ).animate(animation),
            child: child, // child is the value returned by pageBuilder
          ),
        );
      });
}
