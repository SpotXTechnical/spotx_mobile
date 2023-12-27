import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/unit/model/filter_queryies.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_most_popular_bloc.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_state.dart';
import 'package:spotx/presentation/main/screens/home/screens/camp_details/camp_details_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/search_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:spotx/presentation/main/screens/home/widget/home_most_popular_loading_widget.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';

import '../screens/unit_details/model/unit_details_screen_nav_args.dart';
import 'home_unit_card.dart';

class HomeMostPopularWidget extends StatelessWidget {
  const HomeMostPopularWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeMostPopularBloc, HomeState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsetsDirectional.only(start: 24, top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.mostPopular.tr(),
                    style: circularMedium(color: kWhite, fontSize: 19),
                  ),
                  GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                      margin: const EdgeInsetsDirectional.only(end: 27),
                      child: Text(
                        LocaleKeys.viewAll.tr(),
                        style: circularMedium(color: kWhite, fontSize: 12),
                      ),
                    ),
                    onTap: () {
                      navigationKey.currentState?.pushNamed(SearchScreen.tag, arguments: FilterQueries(mostPoplar: 1));
                    },
                  ),
                ],
              ),
              state.mostPopularSectionIsLoading
                  ? UnitsLoadingWidget(
                      cardWidth: MediaQuery.of(context).size.width * .6,
                    )
                  : Container(
                      height: 270,
                      margin: const EdgeInsetsDirectional.only(top: 17),
                      child: ListView.separated(
                        itemCount: state.mostPopularUnits?.length ?? 0,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            indent: 15,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) => GestureDetector(
                          child: state.mostPopularUnits != null
                              ? HomeUnitCard(
                                  unit: state.mostPopularUnits![index],
                                )
                              : Container(),
                          onTap: () {
                            // navigateToUnitDetails(state.mostPopularUnits![index]);
                          },
                        ),
                      ),
                    )
            ],
          ),
        );
      },
    );
  }

  void navigateToUnitDetails(Unit unit) {
    if (unit.type == UnitType.camp.name) {
      navigationKey.currentState?.pushNamed(CampDetailsScreen.tag, arguments: unit.id.toString());
    } else {
      navigationKey.currentState?.pushNamed(UnitDetailsScreen.tag,
          arguments: UnitDetailsScreenNavArgs(unit.id.toString(), UnitDetailsScreenType.normalUnit));
    }
  }
}