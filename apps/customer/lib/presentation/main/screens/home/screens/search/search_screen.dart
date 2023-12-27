import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/regions/regions_repository.dart';
import 'package:spotx/data/remote/unit/model/filter_queryies.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/data/remote/unit/unit_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/filter_screen.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/widget/search_section.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/widget/sort_row.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/widget/unit_card.dart';
import 'package:spotx/presentation/main/screens/home/widget/home_most_popular_loading_widget.dart';
import 'package:spotx/utils/const.dart';
import 'package:spotx/utils/deep_link_utils.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/error_widget.dart';
import 'package:spotx/utils/widgets/header.dart';
import 'package:spotx/utils/widgets/pagination/pagination_list.dart';

import 'bloc/search_bloc.dart';
import 'bloc/search_event.dart';
import 'bloc/search_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  static const tag = "SearchScreen";

  @override
  Widget build(BuildContext context) {
    final filterQueries = ModalRoute.of(context)!.settings.arguments as FilterQueries?;
    return BlocProvider<SearchBloc>(
      create: (ctx) => SearchBloc(UnitRepository(), RegionsRepository())..add(GetUnits(filterQueries)),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          SearchBloc searchBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Column(
                children: [
                  Header(
                    title: LocaleKeys.search.tr(),
                    endIconAction: !state.isLoading
                        ? () => createDynamicLink(
                            "",
                            DynamicLinksTargets.searchResult,
                            jsonEncode(state.filterQueries))
                        : null,
                    endIconPath: shareIconPath,
                  ),
                  SearchSection(
                    regions: state.selectedRegions,
                    onFilterTap: !state.isLoading
                        ? () {
                            handleNavigationToFilterScreen(
                                searchBloc, state.filterQueries
                            );
                          }
                        : null,
                    onSortTap:!state.isLoading
                        ? () {
                      if (state.filterQueries != null) {
                        buildBottomSheet(context, state, searchBloc);
                      }
                    } : null,
                    onItemSelected: (selectedRegions) {
                      searchBloc.add(GetUnits(FilterQueries(
                          regions: List.of(selectedRegions), isComingFromSearchScreenWithSubRegions: true)));
                    },
                  ),
                  if (state.units == null && !state.isLoading)
                    Container()
                  else if (state.isLoading)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 17, bottom: 20),
                        child: UnitsLoadingWidget(
                          scrollDirection: Axis.vertical,
                          height: MediaQuery.of(context).size.height,
                          cardWidth: MediaQuery.of(context).size.width,
                        ),
                      ),
                    )
                  else if (state.isError)
                    Expanded(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: AppErrorWidget(action: () {
                            searchBloc.add(GetUnits(filterQueries));
                          })),
                    )
                  else if (state.units!.isEmpty)
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              LocaleKeys.defaultSearchMessage.tr(),
                              style: circularMedium(color: Theme.of(context).disabledColor, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 17, bottom: 20),
                          child: PaginationList<Unit>(
                            scrollPhysics: (state.units?.length ?? 0) <= 2 ? const AlwaysScrollableScrollPhysics() : null,
                            divider: Divider(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              height: 10,
                            ),
                            isLoading: state.isLoading,
                            hasMore: state.hasMore,
                            list: state.units,
                            loadMore: () {
                              searchBloc.add(LoadMoreUnits());
                            },
                            builder: (Unit unit) {
                              return UnitCardWidget(
                                unit: unit,
                              );
                            },
                            onRefresh: () {
                              searchBloc.add(GetUnits(state.filterQueries));
                            },
                            loadingWidget: UnitsLoadingWidget(
                              scrollDirection: Axis.vertical,
                              height: MediaQuery.of(context).size.height,
                              cardWidth: MediaQuery.of(context).size.width,
                            ),
                          )),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void buildBottomSheet(BuildContext context, SearchState state, SearchBloc searchBloc) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).backgroundColor,
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        builder: (context) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            margin: const EdgeInsetsDirectional.only(end: 35, start: 35, top: 35, bottom: 35),
            child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) => SortRow(
                    index: index,
                    sortType: sortTypes.keys.elementAt(index),
                    selectedSortType: state.filterQueries!.sortType,
                    changeSortType: (sortType) {
                      var filterQueries = state.filterQueries;
                      filterQueries?.sortType = sortType;
                      searchBloc.add(GetUnits(filterQueries));
                    }),
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.transparent,
                  );
                },
                itemCount: sortTypes.length)));
  }

  void handleNavigationToFilterScreen(SearchBloc searchBloc, FilterQueries? filterQueries) async {
    var result =
        await navigationKey.currentState?.pushNamed(FilterScreen.tag, arguments: filterQueries ?? FilterQueries());
    searchBloc.add(GetUnits(result as FilterQueries));
  }
}