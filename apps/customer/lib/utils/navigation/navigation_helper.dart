import 'package:flutter/material.dart';
import 'package:spotx/presentation/auth/login/login_screen.dart';
import 'package:spotx/presentation/auth/register/register_screen.dart';
import 'package:spotx/presentation/auth/register/screens/select_city/select_city_screen.dart';
import 'package:spotx/presentation/auth/reser_password/reset_password_screen.dart';
import 'package:spotx/presentation/common/media_pager/media_pager_screen.dart';
import 'package:spotx/presentation/main/main_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/camp_details/camp_details_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/region/region_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/filter_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/search_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/sub_region/sub_region_details_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/calender_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/screens/summary_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:spotx/presentation/main/screens/myrents/my_rents_screen.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/pending/reservation_details_pending_screen.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/rented/reservation_details_rented_screen.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/screens/rating/rating_screen.dart';
import 'package:spotx/presentation/main/screens/profile/profile_screen.dart';
import 'package:spotx/presentation/main/screens/profile/screens/edit_profile/edit_profile_screen.dart';
import 'package:spotx/presentation/main/screens/profile/screens/favourite/favourite_screen.dart';
import 'package:spotx/presentation/main/screens/profile/screens/settings/settings_screen.dart';
import 'package:spotx/presentation/owner_profile/owner_profile_screen.dart';
import 'package:spotx/presentation/splash/splash_screen.dart';
import 'package:spotx/utils/widgets/login_dialog.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

Route getApplicationRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.tag:
      return _buildRoute(settings, const SplashScreen());

    case LoginScreen.tag:
      return _buildRoute(settings, const LoginScreen());

    case RegisterScreen.tag:
      return _buildRoute(settings, const RegisterScreen());

    case MainScreen.tag:
      return _buildRoute(settings, const MainScreen());

    case CalenderScreen.tag:
      return _buildRoute(settings, const CalenderScreen());

    case UnitDetailsScreen.tag:
      return _buildRoute(settings, const UnitDetailsScreen());

    case SearchScreen.tag:
      return _buildRoute(settings, const SearchScreen());

    case FilterScreen.tag:
      return _buildRoute(settings, const FilterScreen());

    case ProfileScreen.tag:
      return _buildRoute(settings, const ProfileScreen());

    case SelectCityScreen.tag:
      return _buildRoute(settings, const SelectCityScreen());

    case RatingScreen.tag:
      return _buildRoute(settings, const RatingScreen());

    case MyRentsScreen.tag:
      return _buildRoute(settings, const MyRentsScreen());

    case FavouriteScreen.tag:
      return _buildRoute(settings, const FavouriteScreen());

    case RegionScreen.tag:
      return _buildRoute(settings, const RegionScreen());

    case ReservationDetailsRentedScreen.tag:
      return _buildRoute(settings, const ReservationDetailsRentedScreen());

    case ReservationDetailsPendingScreen.tag:
      return _buildRoute(settings, const ReservationDetailsPendingScreen());

    case ResetPasswordScreen.tag:
      return _buildRoute(settings, const ResetPasswordScreen());

    case CampDetailsScreen.tag:
      return _buildRoute(settings, const CampDetailsScreen());

    case SettingsScreen.tag:
      return _buildRoute(settings, const SettingsScreen());

    case SubRegionDetailsScreen.tag:
      return _buildRoute(settings, const SubRegionDetailsScreen());

    case LoginDialog.tag:
      return _buildRoute(settings, const LoginDialog());

    case EditProfileScreen.tag:
      return _buildRoute(settings, const EditProfileScreen());

    case OwnerProfileScreen.tag:
      return _buildRoute(settings, const OwnerProfileScreen());

    case MediaPagerScreen.tag:
      return _buildRoute(settings, const MediaPagerScreen());

    case SummaryScreen.tag:
      return _buildRoute(settings, const SummaryScreen());

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
