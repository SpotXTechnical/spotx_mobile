import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/data/remote/regions/regions_repository.dart';
import 'package:spotx/presentation/main/screens/home/screens/region/widgets/sub_regions_loading_shimmer.dart';
import 'package:spotx/presentation/main/screens/home/screens/sub_region/sub_region_details_screen.dart';
import 'package:spotx/presentation/main/screens/home/widget/region_medium_card.dart';
import 'package:spotx/presentation/widgets/shimmers/region_medium_card_shimmer.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/error_widget.dart';
import 'package:spotx/utils/widgets/header.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';
import 'package:spotx/utils/widgets/pagination/pagination_grid.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../../../utils/widgets/CustomRoundedTextFormField.dart';
import 'bloc/region_bloc.dart';
import 'bloc/region_event.dart';
import 'bloc/region_state.dart';

class RegionScreen extends StatelessWidget {
  const RegionScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "RegionScreen";
  @override
  Widget build(BuildContext context) {
    String searchText = "";
    Region region = ModalRoute.of(context)!.settings.arguments as Region;
    return BlocProvider<RegionBloc>(
      create: (ctx) => RegionBloc(RegionsRepository())..add(GetSubRegions(region: region)),
      child: BlocBuilder<RegionBloc, RegionState>(
        builder: (context, state) {
          RegionBloc regionBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Header(title: region.name ?? ""),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 28, end: 28, top: 16),
                    child: CustomRoundedTextFormField(
                      maxLines: 1,
                      controller: regionBloc.searchController,
                      textInputAction: TextInputAction.done,
                      onChanged: (searchQuery) {
                        EasyDebounce.debounce("SearchDebounce", const Duration(milliseconds: 500), () {
                          if (searchQuery.isNotEmpty && searchQuery != searchText) {
                            regionBloc.add(GetSubRegions(region: region, searchQuery: searchQuery.trim()));
                            searchText = searchQuery;
                          }
                        });
                      },
                      focusNode: regionBloc.searchFocus,
                      hasBorder: true,
                      hintText: LocaleKeys.search.tr(),
                      cursorColor: kWhite,
                      style: const TextStyle(color: kWhite),
                      validator: (value) {},
                    ),
                  ),
                  Expanded(
                    child: state.requestStatus == RequestStatus.loading
                        ? const SubRegionsLoadingShimmer()
                        : state.requestStatus == RequestStatus.failure
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: AppErrorWidget(action: () {
                                  navigationKey.currentState?.pushReplacementNamed(RegionScreen.tag, arguments: region);
                                }))
                            : Padding(
                                padding: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 17, bottom: 20),
                                child: PaginationGrid<Region>(
                                  isLoading: state.requestStatus == RequestStatus.loading,
                                  hasMore: state.hasMore,
                                  list: state.subRegions,
                                  loadMore: () {
                                    regionBloc.add(LoadMoreSubRegions(region: region));
                                  },
                                  builder: (Region region) {
                                    return RegionMediumCard(
                                        region: region,
                                        // multiSelectMode: arguments.multiSelectMode,
                                        // isSelected: state.selectedSubRegionsIds?.contains(region.id) ?? false,
                                        onTap: (region) {
                                          navigationKey.currentState
                                              ?.pushNamed(SubRegionDetailsScreen.tag, arguments: region.id);

                                          // regionBloc
                                          //     .add(ManageSubRegionInList(subRegionId, selectedSubRegion: subRegion));
                                        });
                                  },
                                  onRefresh: () {},
                                  loadingWidget: const LoadingWidget(),
                                  loadMoreLoading: const RegionMediumCardShimmer(),
                                )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}