import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/data/remote/region/region_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/bloc/add_unit_third_bloc.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/bloc/add_unit_third_event.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/model/sub_regions_screen_arguments.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/sub_region_card.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/sub_regions_loading_widget.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/CustomRoundedTextFormField.dart';
import 'package:owner/utils/widgets/app_buttons/app_button.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/header.dart';
import 'package:owner/utils/widgets/pagination/pagination_list.dart';

import '../bloc/add_unit_third_state.dart';

class SubRegionsScreen extends StatelessWidget {
  const SubRegionsScreen({Key? key}) : super(key: key);
  static const String tag = "SubRegionsScreen";
  @override
  Widget build(BuildContext context) {
    SubRegionsScreenArguments arguments = ModalRoute.of(context)!.settings.arguments as SubRegionsScreenArguments;
    String searchText = "";
    return BlocProvider<AddUnitThirdBloc>(
      create: (context) =>
          AddUnitThirdBloc(RegionRepository())..add(SetSelectedSubRegion(arguments.selectedSubRegion ?? Region())),
      child: BlocBuilder<AddUnitThirdBloc, AddUnitThirdState>(builder: (context, state) {
        AddUnitThirdBloc addUnitThirdBloc = BlocProvider.of(context);
        return CustomSafeArea(
          child: CustomScaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Header(title: "${arguments.selectedRegion?.name}"),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 28, end: 28, top: 16),
                  child: CustomRoundedTextFormField(
                    maxLines: 1,
                    controller: addUnitThirdBloc.searchController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onChanged: (searchQuery) {
                      EasyDebounce.debounce("SearchDebounce", const Duration(milliseconds: 500), () {
                        if (searchQuery.isNotEmpty && searchQuery != searchText) {
                          searchText = searchQuery;
                        }
                      });
                    },
                    focusNode: addUnitThirdBloc.searchFocus,
                    hasBorder: true,
                    hintText: LocaleKeys.search.tr(),
                    cursorColor: kWhite,
                    style: TextStyle(color: kWhite),
                    validator: (value) {},
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 17, bottom: 20),
                  child: PaginationList<Region>(
                    isLoading: state.isSubRegionsLoading ?? true,
                    hasMore: false,
                    list: state.subRegions,
                    loadMore: () {},
                    builder: (Region subRegion) {
                      return SubRegionCard(
                        subRegion: subRegion,
                        isSelected: state.selectedSubRegion?.id == subRegion.id,
                        onItemSelected: (subRegion) {
                          addUnitThirdBloc.add(SetSelectedSubRegion(subRegion));
                        },
                      );
                    },
                    onRefresh: () {},
                    loadingWidget: const SubRegionsLoadingWidget(),
                  ),
                )),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 28, end: 28, bottom: 16),
                  child: AppButton(
                    title: LocaleKeys.submit.tr(),
                    textWidget: Text(
                      LocaleKeys.submit.tr(),
                      style: circularMedium(color: kWhite, fontSize: 17),
                    ),
                    action: () {
                      navigationKey.currentState?.pop(state.selectedSubRegion);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}