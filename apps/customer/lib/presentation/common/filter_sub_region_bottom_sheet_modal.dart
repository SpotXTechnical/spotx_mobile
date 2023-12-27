import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/sub_region/region_bloc.dart';
import 'package:spotx/base/sub_region/region_event.dart';
import 'package:spotx/base/sub_region/region_state.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/data/remote/regions/regions_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/CustomRoundedTextFormField.dart';
import 'package:spotx/utils/widgets/app_button.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';
import 'package:spotx/utils/widgets/pagination/subregion_special_pagination_list.dart';

void showFilterBottomSheetModal(BuildContext context, RegionEvent initEvent, String searchText, List<Region>? selectedRegions,
    Function(bool, List<Region>?) onApplyClickedAction, RegionEvent loadMoreEvent) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => BlocProvider<SubRegionBloc>(
            create: (ctx) => SubRegionBloc(RegionsRepository())..add(initEvent),
            child: BlocBuilder<SubRegionBloc, RegionState>(builder: (context, state) {
              SubRegionBloc subRegionBloc = BlocProvider.of(context);

              return Container(
                  height: MediaQuery.of(context).copyWith().size.height * 0.75,
                  margin: const EdgeInsets.all(30),
                  child: Column(children: [
                    Text(LocaleKeys.selectASubRegion.tr(),
                        style: circularBook(color: kWhite, fontSize: 17)),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomRoundedTextFormField(
                      fillColor: Theme.of(context).unselectedWidgetColor,
                      prefixIcon: Image.asset(searchIconPath),
                      maxLines: 1,
                      controller: subRegionBloc.searchController,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onChanged: (searchQuery) {
                        EasyDebounce.debounce("SearchDebounce", const Duration(milliseconds: 500), () {
                            subRegionBloc.add(InitSubRegions(
                              regionIds: selectedRegions?.map((e) => e.id.toString()).toList(),
                              searchQuery: searchQuery.trim(),
                            ));
                            searchText = searchQuery;
                        });
                      },
                      focusNode: subRegionBloc.searchFocus,
                      hintText: LocaleKeys.search.tr(),
                      hintStyle: circularMedium(color: cadetGrey, fontSize: 14),
                      cursorColor: kWhite,
                      style: circularMedium(color: kWhite, fontSize: 15),
                      validator: (value) {},
                    ),
                    if (state.regions != null && state.regions!.isEmpty)
                      Expanded(
                          child: Center(
                              child: Text(
                                  LocaleKeys.noSubRegionWithThisName.tr())))
                    else
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: SubRegionSpecialPaginationList<Region>(
                            divider: Container(
                              height: 3,
                              color: Theme.of(context).backgroundColor,
                            ),
                            isLoading: state.isLoading,
                            list: state.regions,
                            hasMore: state.hasMoreRegions,
                            loadMore: () {
                              subRegionBloc.add(loadMoreEvent);
                            },
                            builder: (Region subRegion) {
                              return GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          subRegion.name ?? "",
                                          style: circularBook(color: Theme.of(context).hintColor, fontSize: 15),
                                        ),
                                      ),
                                      if (state.selectedRegions?.map((e) => e.id).contains(subRegion.id) ?? false)
                                        SizedBox(width: 15, height: 15, child: Image.asset(doneIconPath))
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  subRegionBloc.add(AddOrRemoveSelectedSubRegion(selectedSubRegion: subRegion));
                                },
                              );
                            },
                            prefixLeadingWidget: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        LocaleKeys.all.tr(),
                                        style: circularBook(color: Theme.of(context).canvasColor, fontSize: 15),
                                      ),
                                    ),
                                    if (state.isAllSelected)
                                      SizedBox(width: 15, height: 15, child: Image.asset(doneIconPath))
                                  ],
                                ),
                              ),
                              onTap: () {
                                subRegionBloc.add(const SetAllSubRegionsSelected());
                              },
                            ),
                            loadingWidget: const LoadingWidget(),
                          ),
                        ),
                      ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: AppButton(
                        title: LocaleKeys.login.tr(),
                        height: 55,
                        borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
                        textWidget: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(28)),
                          ),
                          child: Center(
                              child: Text(LocaleKeys.apply.tr(),
                                  style: circularMedium(color: kWhite, fontSize: 17))),
                        ),
                        action: () async {
                          onApplyClickedAction(state.isAllSelected, state.selectedRegions);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ]));
            }),
          ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor);
}