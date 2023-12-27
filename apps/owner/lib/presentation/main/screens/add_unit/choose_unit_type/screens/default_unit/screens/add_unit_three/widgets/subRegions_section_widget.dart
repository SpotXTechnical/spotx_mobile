import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/sub_region/sub_region_bloc.dart';
import 'package:owner/base/sub_region/sub_region_event.dart';
import 'package:owner/base/sub_region/sub_region_state.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/data/remote/region/region_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/bloc/add_unit_third_bloc.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/CustomRoundedTextFormField.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';
import 'package:owner/utils/widgets/loading_widget.dart';
import 'package:owner/utils/widgets/pagination/subregion_special_pagination_list.dart';

class SubRegionSectionWidget extends StatelessWidget {
  SubRegionSectionWidget({
    Key? key,
    this.selectedSubRegion,
    required this.addSetSubRegionEvent,
    required this.title,
    this.controller,
    required this.selectedRegion,
  }) : super(key: key);

  final String title;
  final Region? selectedSubRegion;
  final Function(Region) addSetSubRegionEvent;
  final TextEditingController? controller;
  final Region? selectedRegion;
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: AddUnitThirdBloc.subRegionFormKey,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
            child: CustomTitledRoundedTextFormWidget(
              suffixIcon: Image.asset(arrowDownIcon, color: kWhite),
              controller: controller,
              hintText: LocaleKeys.pleaseChooseSubRegionHint.tr(),
              title: LocaleKeys.subRegion.tr(),
              textStyle: circularBook(
                color: Theme.of(context).dividerColor,
                fontSize: 15,
              ),
              keyboardType: TextInputType.text,
              sideTitle: LocaleKeys.optional.tr(),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (name) {},
              validator: (value) {
                if (selectedRegion == null) {
                  return LocaleKeys.pleaseChooseRegionHint.tr();
                } else {
                  return null;
                }
              },
            ),
          ),
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: 80,
            ),
            onTap: () async {
              if (selectedRegion != null) {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => BlocProvider<SubRegionBloc>(
                          create: (ctx) => SubRegionBloc(RegionRepository())
                            ..add(GetSubRegions(regionId: selectedRegion!.id.toString())),
                          child: BlocBuilder<SubRegionBloc, SubRegionState>(builder: (context, state) {
                            SubRegionBloc subRegionBloc = BlocProvider.of(context);
                            List<Region>? newList;
                            if (selectedSubRegion != null) {
                              newList = state.subRegions?.map((e) => e.clone()).toList(growable: true);
                              newList?.removeWhere((element) => element.id == selectedSubRegion?.id);
                              newList?.insertAll(0, [selectedSubRegion!]);
                            } else {
                              newList = state.subRegions;
                            }
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
                                        if (searchQuery.isNotEmpty && searchQuery != searchText) {
                                          subRegionBloc.add(GetSubRegions(
                                            regionId: selectedRegion?.id.toString() ?? "",
                                            searchQuery: searchQuery.trim(),
                                          ));
                                          searchText = searchQuery;
                                        }
                                      });
                                    },
                                    focusNode: subRegionBloc.searchFocus,
                                    hintText: LocaleKeys.search.tr(),
                                    hintStyle: circularMedium(color: Theme.of(context).dividerColor, fontSize: 14),
                                    cursorColor: kWhite,
                                    style: circularMedium(color: kWhite, fontSize: 15),
                                    validator: (value) {},
                                  ),
                                  (newList != null && newList.isEmpty)
                                      ? searchText.isEmpty
                                          ? Expanded(child: Center(child: Text(LocaleKeys.noDataMessage.tr())))
                                          : Expanded(
                                              child: Center(child: Text(LocaleKeys.noSubRegionWithThisName.tr())))
                                      : Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.only(top: 20),
                                            child: SubRegionSpecialPaginationList<Region>(
                                              divider: Container(
                                                height: 3,
                                                color: Theme.of(context).backgroundColor,
                                              ),
                                              isLoading: state.isLoading,
                                              list: newList,
                                              hasMore: state.hasMoreSubRegions,
                                              loadMore: () {
                                                subRegionBloc
                                                    .add(LoadMoreSubRegions(regionId: selectedRegion!.id.toString()));
                                              },
                                              firstItemBuilder: selectedSubRegion != null
                                                  ? (Region subRegion) {
                                                      return GestureDetector(
                                                        behavior: HitTestBehavior.translucent,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(vertical: 16, horizontal: 8.0),
                                                          child: Text(
                                                            subRegion.name ?? "",
                                                            style: circularBook(
                                                                color: Theme.of(context).canvasColor, fontSize: 15),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          addSetSubRegionEvent(subRegion);
                                                          Navigator.of(context).pop();
                                                        },
                                                      );
                                                    }
                                                  : null,
                                              builder: (Region subRegion) {
                                                return GestureDetector(
                                                  behavior: HitTestBehavior.translucent,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8.0),
                                                    child: Text(
                                                      subRegion.name ?? "",
                                                      style: circularBook(
                                                          color: Theme.of(context).hintColor, fontSize: 15),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    addSetSubRegionEvent(subRegion);
                                                    Navigator.of(context).pop();
                                                  },
                                                );
                                              },
                                              loadingWidget: const LoadingWidget(),
                                            ),
                                          ),
                                        ),
                                ]));
                          }),
                        ),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor);
              } else {
                AddUnitThirdBloc.subRegionFormKey.currentState?.validate();
              }
            },
          ),
        ],
      ),
    );
  }
}