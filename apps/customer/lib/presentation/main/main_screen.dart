import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/presentation/main/screens/home/home_screen.dart';
import 'package:spotx/presentation/main/screens/myrents/my_rents_screen.dart';
import 'package:spotx/presentation/main/screens/offer/offers_screen.dart';
import 'package:spotx/presentation/main/screens/profile/profile_screen.dart';
import 'package:spotx/utils/icons/bottom_navigation_bar_icons.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/utils.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import 'bloc/main_bloc.dart';
import 'bloc/main_event.dart';
import 'bloc/main_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const tag = "MainScreen";
  @override
  Widget build(BuildContext context) {
    final int? pageIndex = ModalRoute.of(context)?.settings.arguments as int?;
    return BlocProvider(
      create: (ctx) => MainBloc(pageIndex ?? (isArabic ? 3 : 0))
        ..add(UpdateIndexAndLanguage(
          isArabic ? 3 : 0,
          isArabic,
        )),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          MainBloc mainBloc = BlocProvider.of(context);
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
                systemNavigationBarColor: kWhite,
                systemNavigationBarIconBrightness: Brightness.dark),
            child: CustomScaffold(
              body: MainBody(index: state.selectedIndex, isAr: state.isArabic),
              bottomNavigationBar: Directionality(
                textDirection: TextDirection.ltr,
                child: WaterDropNavBar(
                  bottomPadding: 30,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  inactiveIconColor: Theme.of(context).primaryColorLight,
                  waterDropColor: Theme.of(context).primaryColorLight,
                  onItemSelected: (index) {
                    mainBloc.add(UpdateIndex(index, previousIndex:  state.selectedIndex));
                  },
                  selectedIndex: state.selectedIndex,
                  barItems: state.isArabic ? arBarItems : enBarItems,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

final enBarItems = [
  BarItem(
    filledIcon: BottomNavigationBarIcons.ic_home_active,
    outlinedIcon: BottomNavigationBarIcons.ic_home,
  ),
  BarItem(
    filledIcon: BottomNavigationBarIcons.ic_offer_active,
    outlinedIcon: BottomNavigationBarIcons.ic_offer,
  ),
  BarItem(
    filledIcon: BottomNavigationBarIcons.ic_myrent_active,
    outlinedIcon: BottomNavigationBarIcons.ic_myrent,
  ),
  BarItem(
    filledIcon: BottomNavigationBarIcons.ic_profile_active,
    outlinedIcon: BottomNavigationBarIcons.ic_profile,
  ),
];

final arBarItems = [
  BarItem(
    filledIcon: BottomNavigationBarIcons.ic_profile_active,
    outlinedIcon: BottomNavigationBarIcons.ic_profile,
  ),
  BarItem(
    filledIcon: BottomNavigationBarIcons.ic_myrent_active,
    outlinedIcon: BottomNavigationBarIcons.ic_myrent,
  ),
  BarItem(
    filledIcon: BottomNavigationBarIcons.ic_offer_active,
    outlinedIcon: BottomNavigationBarIcons.ic_offer,
  ),
  BarItem(
    filledIcon: BottomNavigationBarIcons.ic_home_active,
    outlinedIcon: BottomNavigationBarIcons.ic_home,
  ),
];



class MainBody extends StatelessWidget {
  const MainBody({
    Key? key,
    required this.index, required this.isAr,
  }) : super(key: key);

  final int index;
  final bool isAr;

  final enScreens = const [
    HomeScreen(),
    OffersScreen(),
    MyRentsScreen(),
    ProfileScreen()
  ];
  final arScreens = const [
    ProfileScreen(),
    MyRentsScreen(),
    OffersScreen(),
    HomeScreen()
  ];

  @override
  Widget build(BuildContext context) {

    return IndexedStack(
      index: index,
      children: isAr ? arScreens : enScreens,
    );
  }
}