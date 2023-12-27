import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/auth/auth_repository.dart';
import 'package:spotx/data/remote/regions/regions_repository.dart';
import 'package:spotx/data/remote/unit/unit_repository.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_bloc.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_event.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_most_popular_bloc.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_region_bloc.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_state.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_sub_region_bloc.dart';
import 'package:spotx/presentation/main/screens/home/widget/home_discover_and_book_widget.dart';
import 'package:spotx/presentation/main/screens/home/widget/home_most_popular_widget.dart';
import 'package:spotx/presentation/main/screens/home/widget/home_offer_widget.dart';
import 'package:spotx/presentation/main/screens/home/widget/home_region_widget.dart';
import 'package:spotx/presentation/main/screens/home/widget/home_most_popular_region_widget.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';

import 'package:spotx/utils/deep_link_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint("target= WidgetsBinding");
      listenToDeepLinking();
    });

    return BlocProvider<HomeBloc>(
      create: (ctx) => HomeBloc(AuthRepository())..add(HomeGetProfileData()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return MultiBlocProvider(
              providers: [
                BlocProvider<HomeRegionBloc>(
                  create: (ctx) => HomeRegionBloc(regionsRepository: RegionsRepository())..add(const GetRegions()),
                ),
                BlocProvider<HomeSubRegionBloc>(
                  create: (ctx) => HomeSubRegionBloc(regionRepository: RegionsRepository())..add(const GetSubRegions()),
                ),
                BlocProvider<HomeMostPopularBloc>(
                  create: (ctx) => HomeMostPopularBloc(AuthRepository(), unitRepository: UnitRepository())
                    ..add(const GetMostPopularUnits())
                    ..add(const HomeGetProfileData()),
                ),
              ],
              child: CustomSafeArea(
                child: CustomScaffold(
                  /*appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(60),
                    child: HomeHeader(user: state.user),
                  ),*/
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  body: SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: const [
                          HomeDiscoverAndBookWidget(),
                          HomeRegionWidget(),
                          HomeMostPopularWidget(),
                          HomeOfferWidget(),
                          HomeMostPopularRegions(),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

  Future<void> listenToDeepLinking() async {
    //handle deep linking while app is not in background
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      handleDynamicLink(initialLink.link.queryParameters);
    }
  }
}