import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_state.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_sub_region_bloc.dart';
import 'package:spotx/presentation/main/screens/home/screens/region/region_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/sub_region/sub_region_details_screen.dart';
import 'package:spotx/presentation/main/screens/home/widget/region_medium_card.dart';
import 'package:spotx/presentation/main/screens/home/widget/shimmer/home_most_popular_regions_shimmer.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';

class HomeMostPopularRegions extends StatelessWidget {
  const HomeMostPopularRegions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeSubRegionBloc, HomeState>(builder: (context, state) {
      return Container(
          margin: const EdgeInsetsDirectional.only(start: 24, top: 24, bottom: 20),
          child: state.subRegionsSectionIsLoading
              ? const HomeMostPopularRegionsShimmer()
              : Column(
                  children: renderMostPopularRegions(state.mostPopularRegions, context, state),
                ));
    });
  }

  List<Widget> renderMostPopularRegions(List<Region>? mostPopularRegions, BuildContext context, HomeState state) {
    List<Widget> list = List.empty(growable: true);
    mostPopularRegions?.asMap().forEach((key, value) {
      list.add(
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value.name ?? "",
                    style: circularMedium(color: kWhite, fontSize: 19),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigationKey.currentState?.pushNamed(RegionScreen.tag, arguments: value);
                    },
                    child: Container(
                      color: Colors.transparent,
                      margin: const EdgeInsetsDirectional.only(end: 27),
                      child: Text(
                        LocaleKeys.viewAll.tr(),
                        style: circularMedium(color: kWhite, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(top: 17),
                height: 130,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: value.subRegions?.length ?? 0,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      indent: 15,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) => value.subRegions?.elementAt(index) != null
                      ? RegionMediumCard(
                          region: value.subRegions!.elementAt(index),
                          onTap: (region) {
                            navigationKey.currentState?.pushNamed(SubRegionDetailsScreen.tag, arguments: region.id);
                          })
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      );
    });
    return list;
  }
}