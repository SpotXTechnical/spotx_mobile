import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/data/remote/regions/regions_repository.dart';
import 'package:spotx/data/remote/unit/model/filter_queryies.dart';
import 'package:spotx/data/remote/unit/unit_repository.dart';
import 'package:spotx/presentation/main/screens/home/screens/region/model/region_screen_argument.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/utils.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/widgets/apply_button_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/widgets/bed_section_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/widgets/beds_section_loading_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/widgets/header_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/widgets/home_type_secction_loading_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/widgets/home_type_section_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/widgets/price_section_loading_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/widgets/price_section_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/widgets/regions_section_loading_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/widgets/regions_section_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/widgets/rooms_section_loading_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/widgets/rooms_section_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/screens/filter/widgets/sub_regions_section_widget_Many_choices.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'bloc/filter_bloc.dart';
import 'bloc/filter_event.dart';
import 'bloc/filter_state.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);
  static const tag = "FilterScreen";

  @override
  Widget build(BuildContext context) {
    final filterQuery = ModalRoute.of(context)!.settings.arguments as FilterQueries;
    return BlocProvider<FilterBloc>(
      create: (ctx) => FilterBloc(regionsRepository: RegionsRepository(), unitRepository: UnitRepository())
        ..add(GetFilterData(filterQuery))
        ..add(const GetRegionsWithSubRegion()),
      child: BlocBuilder<FilterBloc, FilterState>(builder: (context, state) {
        FilterBloc filterBloc = BlocProvider.of(context);
        return CustomSafeArea(
            child: CustomScaffold(
          appBar: FilterScreenHeaderWidget(
            resetAction: () {
              filterBloc.add(const ResetFilterEvent());
            },
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                buildHomeTypeSection(state, filterBloc),
                Container(
                  color: Theme.of(context).splashColor,
                  height: .5,
                  margin: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                ),
                buildRegionSection(state, filterBloc),
                if (!state.hideSubRegionSection) buildSubRegionSection(state, filterBloc, context),
                if (!state.hideSubRegionSection)
                  Container(
                    color: Theme.of(context).splashColor,
                    height: .5,
                    margin: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                  ),
                buildRoomsSection(state, filterBloc),
                Container(
                  color: Theme.of(context).splashColor,
                  height: .5,
                  margin: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                ),
                buildBedsSection(state, filterBloc),
                Container(
                  color: Theme.of(context).splashColor,
                  height: .5,
                  margin: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                ),
                buildPriceSection(state, filterBloc),
                ApplyButtonWidget(
                  addApplyEvent: () {
                    filterBloc.add(const Apply());
                  },
                ),
              ],
            ),
          ),
        ));
      }),
    );
  }

  Widget buildHomeTypeSection(FilterState state, FilterBloc filterBloc) {
    if (state.unitsFilterConfigData != null && state.unitsFilterConfigData!.types != null) {
      return HomeTypeSectionWidget(
          allHomeTypesSelected: state.allHomeTypesSelected,
          selectedHomeTypes: state.selectedHomeTypes,
          homeTypes: state.unitsFilterConfigData!.types!,
          addSetHomeTypesEvent: (homeTypes) {
            if (state.selectedHomeTypes.isNotEmpty && homeTypes.isEmpty) {
              selectAllHomeTypes(filterBloc, state);
            } else {
              filterBloc.add(SetHomeType(homeTypes));
            }
          },
          addSelectAllHomeTypesEvent: () {
            if (!state.allHomeTypesSelected) {
              selectAllHomeTypes(filterBloc, state);
            }
          });
    } else {
      if (state.isGetUnitFilterConfigDataApiError) {
        return Container();
      } else {
        return const HomeTypeSectionLoadingWidget();
      }
    }
  }

  void selectAllHomeTypes(FilterBloc filterBloc, FilterState state) {
    filterBloc.add(SelectAllHomeTypes(
        state.unitsFilterConfigData!.types!.map((e) => e.value!).toList(), !state.allHomeTypesSelected));
  }

  Widget buildRegionSection(FilterState state, FilterBloc filterBloc) {
    if (state.regions != null && state.regions!.isNotEmpty) {
      return RegionSectionWidget(
          allRegionsSelected: state.allRegionSelected,
          selectedRegions: state.selectedRegions,
          regions: state.regions!,
          addSetRegionEvent: (regionList) {
            if (state.selectedRegions.isNotEmpty && regionList.isEmpty) {
              filterBloc.add(SelectAllRegions(state.regions!, !state.allRegionSelected));
            } else {
              filterBloc.add(SetRegion(regionList));
            }
          },
          addSelectAllRegionsEvent: () {
            if (!state.allRegionSelected) {
              filterBloc.add(SelectAllRegions(state.regions!, !state.allRegionSelected));
            }
          });
    } else {
      if (state.isGetRegionsAndSubRegionsApiError) {
        return Container();
      } else {
        return const RegionsSectionLoadingWidget();
      }
    }
  }

  Widget buildSubRegionSection(FilterState state, FilterBloc filterBloc, BuildContext context) {
    if (state.regions != null && state.regions!.isNotEmpty) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SubRegionsSectionManyChoicesWidget(
          controller: filterBloc.subRegionController,
          setSubRegionListEvent: (subRegions) {
            filterBloc.add(SetSubRegion(subRegions));
          },
          setRegionListEvent: (regionsList) {
            if (regionsList != null) {
              filterBloc.add(SetAllSubRegions(regionsList));
            }
          },
          title: "ahmed",
          selectedRegions: filterBloc.selectedRegionsToSubmit,
          selectedSubRegions: state.selectedSubRegions,
        )
      ]);
    } else {
      return Container();
    }
  }

  Widget buildRoomsSection(FilterState state, FilterBloc filterBloc) {
    if (state.unitsFilterConfigData != null && state.unitsFilterConfigData?.maxPrice != null) {
      return RoomsSectionWidget(
          allRoomsNumbersSelected: state.allRoomsNumbersSelected,
          selectedRoomsNumbers: state.selectedRoomsNumbers,
          roomsNumbers: generateListUntilMax(state.unitsFilterConfigData?.maxRooms!),
          addSetRoomsEvent: (roomsNumbers) {
            if (state.selectedRoomsNumbers.isNotEmpty && roomsNumbers.isEmpty) {
              selectAllRoomsNumbers(filterBloc, state);
            } else {
              filterBloc.add(SetRoom(roomsNumbers));
            }
          },
          addSelectAllRoomsEvent: () {
            if (!state.allRoomsNumbersSelected) {
              selectAllRoomsNumbers(filterBloc, state);
            }
          });
    } else if (state.isGetUnitFilterConfigDataApiError) {
      return Container();
    } else {
      return const RoomsSectionLoadingWidget();
    }
  }

  void selectAllRoomsNumbers(FilterBloc filterBloc, FilterState state) {
    filterBloc.add(
        SelectAllRoomsNumbers(List.filled(state.unitsFilterConfigData!.maxRooms!, 1), !state.allRoomsNumbersSelected));
  }

  Widget buildBedsSection(FilterState state, FilterBloc filterBloc) {
    if (state.unitsFilterConfigData != null && state.unitsFilterConfigData?.maxBeds != null) {
      return BedSectionWidget(
          allBedsNumbersSelected: state.allBedsNumbersSelected,
          selectedBedsNumbers: state.selectedBedsNumbers,
          bedsNumbers: generateListUntilMax(state.unitsFilterConfigData?.maxBeds!),
          addSetBedsNumbersEvent: (bedsNumbers) {
            if (state.selectedBedsNumbers.isNotEmpty && bedsNumbers.isEmpty) {
              selectAllBedsNumbers(filterBloc, state);
            } else {
              filterBloc.add(SetBed(bedsNumbers));
            }
          },
          addSelectAllBedsNumbersEvent: () {
            if (!state.allBedsNumbersSelected) {
              selectAllBedsNumbers(filterBloc, state);
            }
          });
    } else if (state.isGetUnitFilterConfigDataApiError) {
      return Container();
    } else {
      return const BedsSectionLoadingWidget();
    }
  }

  void selectAllBedsNumbers(FilterBloc filterBloc, FilterState state) {
    filterBloc.add(
        SelectAllBedsNumbers(List.filled(state.unitsFilterConfigData!.maxBeds!, 1), !state.allBedsNumbersSelected));
  }

  Widget buildPriceSection(FilterState state, FilterBloc filterBloc) {
    if (state.unitsFilterConfigData != null && state.unitsFilterConfigData?.maxPrice != null) {
      return PriceSectionWidget(
        rangeValues: state.rangeValues!,
        unitFilterConfigData: state.unitsFilterConfigData!,
        addSetValuesRange: (rangeValues) {
          filterBloc.add(SetValuesRange(rangeValues));
        },
      );
    } else if (state.isGetUnitFilterConfigDataApiError) {
      return Container();
    } else {
      return const PriceSectionLoadingWidget();
    }
  }

  buildMiniRegionList(List<int> selectedRegions, List<Region>? regions, bool allRegionSelected) {
    List<MiniRegion>? miniRegions = List.empty(growable: true);
    if (allRegionSelected) {
      miniRegions = regions?.map((e) => MiniRegion(e.id!, e.name!)).toList();
    }
    for (var id in selectedRegions) {
      regions?.forEach((element) {
        if (element.id == id) {
          miniRegions?.add(MiniRegion(element.id!, element.name!));
        }
      });
    }
    return miniRegions;
  }
}