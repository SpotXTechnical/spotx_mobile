import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_one/add_unit_first_screen.dart';
import 'package:owner/presentation/main/screens/home/home_screen.dart';
import 'package:owner/presentation/main/screens/profile/profile_screen.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/reservations_screen.dart';
import 'package:owner/presentation/main/screens/statistics/statistics_screen.dart';
import 'package:owner/utils/icons/bubble_bottom_navigation_bar_icons_icons.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/utils.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import 'bloc/main_bloc.dart';
import 'bloc/main_event.dart';
import 'bloc/main_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const tag = "MainScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => MainBloc(),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          MainBloc mainBloc = BlocProvider.of(context);
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            child: Scaffold(
              body: MainBody(
                index: state.selectedIndex,
              ),
              bottomNavigationBar: Directionality(
                textDirection: TextDirection.ltr,
                child: WaterDropNavBar(
                  bottomPadding: 30,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  inactiveIconColor: Theme.of(context).disabledColor,
                  waterDropColor: Theme.of(context).primaryColorLight,
                  onItemSelected: (index) {
                    mainBloc.add(UpdateIndex(index, state.selectedIndex));
                  },
                  selectedIndex: state.selectedIndex,
                  barItems: isArabic ? arBarItems : enBarItems,
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  navigationKey.currentState?.pushNamed(AddUnitFirstScreen.tag);
                },
                backgroundColor: Colors.green,
                child: Image.asset(addRequestIconPath),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ),
          );
        },
      ),
    );
  }
}

final enBarItems = [
  BarItem(
    filledIcon: BubbleBottomNavigationBarIcons.ic_home_active,
    outlinedIcon: BubbleBottomNavigationBarIcons.ic_home,
  ),
  BarItem(
    filledIcon: BubbleBottomNavigationBarIcons.ic_calendar_active,
    outlinedIcon: BubbleBottomNavigationBarIcons.ic__calendar,
  ),
  BarItem(
    filledIcon: BubbleBottomNavigationBarIcons.ic__statistic_active,
    outlinedIcon: BubbleBottomNavigationBarIcons.ic__statistic,
  ),
  BarItem(
    filledIcon: BubbleBottomNavigationBarIcons.ic_profile_active,
    outlinedIcon: BubbleBottomNavigationBarIcons.ic_profile,
  ),
];

final arBarItems = [
  BarItem(
    filledIcon: BubbleBottomNavigationBarIcons.ic_profile_active,
    outlinedIcon: BubbleBottomNavigationBarIcons.ic_profile,
  ),
  BarItem(
    filledIcon: BubbleBottomNavigationBarIcons.ic__statistic_active,
    outlinedIcon: BubbleBottomNavigationBarIcons.ic__statistic,
  ),
  BarItem(
    filledIcon: BubbleBottomNavigationBarIcons.ic_calendar_active,
    outlinedIcon: BubbleBottomNavigationBarIcons.ic__calendar,
  ),
  BarItem(
    filledIcon: BubbleBottomNavigationBarIcons.ic_home_active,
    outlinedIcon: BubbleBottomNavigationBarIcons.ic_home,
  ),
];

class MainBody extends StatelessWidget {
  const MainBody({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  final enScreens = const [
    HomeScreen(),
    ReservationScreen(),
    StatisticsScreen(),
    ProfileScreen()
  ];

  final arScreens = const [
    ProfileScreen(),
    StatisticsScreen(),
    ReservationScreen(),
    HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: isArabic ? arScreens : enScreens,
    );
  }
}