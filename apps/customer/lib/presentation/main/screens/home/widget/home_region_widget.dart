import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_region_bloc.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_state.dart';
import 'package:spotx/presentation/main/screens/home/screens/region/region_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/sub_region/sub_region_details_screen.dart';
import 'package:spotx/presentation/main/screens/home/widget/region_medium_card.dart';
import 'package:spotx/presentation/main/screens/home/widget/shimmer/home_region_shimmer.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';

class HomeRegionWidget extends StatelessWidget {
  const HomeRegionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeRegionBloc, HomeState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsetsDirectional.only(start: 24, top: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                LocaleKeys.ourDestination.tr(),
                style: circularMedium(color: kWhite, fontSize: 19),
              ),
              state.ourDestinationIsLoading
                  ? const HomeRegionShimmer()
                  : Container(
                      margin: const EdgeInsetsDirectional.only(top: 17),
                      height: 130,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.regions?.length ?? 0,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            indent: 15,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) => GestureDetector(
                          child: RegionMediumCard(
                            region: state.regions![index],
                            onTap: (region) {
                              var region = state.regions![index];
                              if (region.subRegionCount != 0) {
                                String name = state.regions![index].name!;
                                int id = state.regions![index].id!;
                                debugPrint("Home main region selected id $id and name $name");
                                navigationKey.currentState?.pushNamed(RegionScreen.tag, arguments: region);
                              } else {
                                navigationKey.currentState
                                    ?.pushNamed(SubRegionDetailsScreen.tag, arguments: state.regions![index].id);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}