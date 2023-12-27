import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/add_unit/unit_repository.dart';
import 'package:owner/data/remote/auth/auth_repository.dart';
import 'package:owner/data/remote/region/region_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_one/add_unit_first_screen.dart';
import 'package:owner/presentation/main/screens/home/bloc/home_bloc.dart';
import 'package:owner/presentation/main/screens/home/bloc/home_event.dart';
import 'package:owner/presentation/main/screens/home/bloc/home_state.dart';
import 'package:owner/presentation/main/screens/home/widget/home_camp_rooms_widget.dart';
import 'package:owner/presentation/main/screens/home/widget/home_camps_widget.dart';
import 'package:owner/presentation/main/screens/home/widget/home_header.dart';
import 'package:owner/presentation/main/screens/home/widget/home_properties_widget.dart';
import 'package:owner/presentation/main/screens/home/widget/home_units_loading_widget.dart';
import 'package:owner/presentation/main/screens/home/widget/sub_region_unit_card.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/loading_widget.dart';
import 'package:owner/utils/widgets/pagination/pagination_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  static const tag = "HomeScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (ctx) => HomeBloc(UnitRepository(), RegionRepository(), AuthRepository())
        ..add(const GetHomeCampsEvent())
        ..add(const GetRegionsEvent())
        ..add(const SelectAllRegions())
        ..add(const GetUserEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          HomeBloc homeBloc = BlocProvider.of(context);
          return CustomSafeArea(
              child: Scaffold(
            appBar: HomeHeader(
              user: state.user,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: state.isCampsEmpty && state.isRegionsEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    child: Image.asset(emptyIconPath),
                                    onTap: () => navigationKey.currentState
                                        ?.pushNamed(AddUnitFirstScreen.tag),
                                  ),
                                  Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    LocaleKeys.homeEmptyDataMessage.tr(),
                                    style: poppinsMedium(color: Theme.of(context).disabledColor, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                      )
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        !state.isCampsEmpty
                            ? state.camps != null && state.camps!.isNotEmpty && !state.isCampLoading
                                ? HomeCampsWidget(
                                    camps: state.camps!,
                                  )
                                : Container(margin: const EdgeInsets.only(top: 20), child: const LoadingWidget())
                            : Container(),
                        state.camp != null && state.isOnlyOneCamp
                            ? HomeCampRoomsWidget(
                                camp: state.camp!,
                              )
                            : Container(),
                        !state.isRegionsEmpty && state.regionUnits != null && state.regionUnits!.isNotEmpty
                            ? state.regions != null && !state.isRegionsLoading
                                ? HomePropertiesWidget(
                                    selectedRegion: state.selectedRegionId ?? [],
                                    addSelectAllRegionsEvent: () {
                                      homeBloc.add(const SelectAllRegions());
                                    },
                                    addSetRegionEvent: (regionId) {
                                      homeBloc.add(GetRegionUnitsEvent([regionId]));
                                    },
                                    regions: state.regions!,
                                    isAllSelected: state.isAllRegionsSelected,
                                  )
                                : Container(margin: const EdgeInsets.only(top: 20), child: const LoadingWidget())
                            : Container(),
                        state.regionUnits != null && !state.isRegionUnitsLoading
                            ? Padding(
                                padding: const EdgeInsetsDirectional.only(start: 24, end: 24, bottom: 20, top: 20),
                                child: PaginationList<Unit>(
                                  isLoading: state.isRegionUnitsLoading,
                                  hasMore: false,
                                  list: state.regionUnits!,
                                  loadMore: () {},
                                  builder: (Unit unit) {
                                    return SubRegionUnitCard(
                                      unit: unit,
                                      deleteAction: (id) {
                                        homeBloc.add(DeleteUnit(id));
                                      },
                                    );
                                  },
                                  onRefresh: () {},
                                  loadingWidget: const LoadingWidget(),
                                ))
                            : Container(margin: const EdgeInsets.only(top: 20), child: const HomeUnitsLoadingWidget()),
                      ],
                    ),
                  ),
          ));
        },
      ),
    );
  }
}