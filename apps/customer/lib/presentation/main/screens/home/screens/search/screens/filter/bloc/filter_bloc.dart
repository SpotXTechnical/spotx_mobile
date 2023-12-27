import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/regions/i_regions_repository.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/data/remote/unit/i_unit_repository.dart';
import 'package:spotx/data/remote/unit/model/filter_queryies.dart';
import 'package:spotx/data/remote/unit/model/unit_filter_config_entity.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/network/api_response.dart';

import 'filter_bloc_utils.dart';
import 'filter_event.dart';
import 'filter_state.dart';

class FilterBloc extends BaseBloc<FilterEvent, FilterState> {
  FilterBloc({required this.regionsRepository, required this.unitRepository}) : super(const FilterState()) {
    on<SetHomeType>(_setHomeTypes);
    on<SetAllSubRegions>(_setAllSubRegions);
    on<SetRegion>(_setRegions);
    on<SetSubRegion>(_setSubRegions);
    on<SetRoom>(_setRooms);
    on<SetBed>(_setBeds);
    on<SetValuesRange>(_setValuesRange);
    on<GetFilterData>(_getFilterData);
    on<SelectAllRegions>(_selectAllRegions);
    on<SelectAllRoomsNumbers>(_selectAllRoomsNumbers);
    on<SelectAllBedsNumbers>(_selectAllBedsNumbers);
    on<SelectAllHomeTypes>(_selectAllHomeTypes);
    on<Apply>(_apply);
    on<ResetFilterEvent>(_reset);
    on<SetFilterQuery>(_setFilterQueries);
  }

  //Those Are The Selected Data From User
  //When Apply is clicked The Data will be Taken from here except selectedRegionsId which will be filtered by not containing subRegions regions.
  List<Region> selectedRegionsToSubmit = List.empty(growable: true);
  List<Region> selectedSubRegionsToSubmit = List.empty(growable: true);
  List<int> selectedRoomsNumbers = List.empty(growable: true);
  List<int> selectedBedsNumbers = List.empty(growable: true);
  List<String> selectedHomeTypes = List.empty(growable: true);
  RangeValues? priceRange;
  RangeValues? defaultPriceRange;
  TextEditingController subRegionController = TextEditingController();

  final IRegionsRepository regionsRepository;
  final IUnitRepository unitRepository;

  FutureOr<void> _setHomeTypes(SetHomeType event, Emitter<FilterState> emit) {
    selectedHomeTypes = event.homeTypeList;
    emit(state.copyWith(selectedHomeTypes: event.homeTypeList, allHomeTypesSelected: false));
  }

  FutureOr<void> _selectAllHomeTypes(SelectAllHomeTypes event, Emitter<FilterState> emit) {
    List<String> selectedHomeTypes = List.empty(growable: true);
    if (event.isAllHomeTypesSelected) {
      event.homeTypes.asMap().forEach((key, value) {
        selectedHomeTypes.add(value);
      });
    }
    this.selectedHomeTypes = selectedHomeTypes;
    emit(state.copyWith(allHomeTypesSelected: event.isAllHomeTypesSelected, selectedHomeTypes: List.empty()));
  }

  FutureOr<void> _setRooms(SetRoom event, Emitter<FilterState> emit) {
    selectedRoomsNumbers = event.roomList;
    emit(state.copyWith(selectedRoomsNumbersList: event.roomList, allRoomsNumbersSelected: false));
  }

  FutureOr<void> _setBeds(SetBed event, Emitter<FilterState> emit) {
    selectedBedsNumbers = event.bedList;
    emit(state.copyWith(selectedBedsNumbersList: event.bedList, allBedsNumbersSelected: false));
  }

  FutureOr<void> _setValuesRange(SetValuesRange event, Emitter<FilterState> emit) {
    priceRange = event.rangeValues;
    emit(state.copyWith(rangeValues: event.rangeValues));
  }

  FutureOr<void> _getFilterData(GetFilterData event, Emitter<FilterState> emit) async {
    //GetRegionService and GetFilterConfig are Synchronized to be called as one Service with one success and one failure; why?
    //Because setFilterQuery event depends on both so we should ensure both were called.
    List<ApiResponse> apiResponses = await unitRepository.getFilterData();
    await handleMultipleResponse(
        result: apiResponses,
        onSuccess: () {
          initializeRegionData(emit, apiResponses[0]);
          setFilterConfig(emit, apiResponses[1]);
          add(SetFilterQuery(event.filterQueries));
        },
        onFailed: () {
          showErrorMsg("Some thing Error has been happened");
        });
  }

  void setFilterConfig(Emitter<FilterState> emit, ApiResponse apiResponse) {
    if (apiResponse.data != null) {
      UnitFilterConfigEntity data = apiResponse.data.data;
      List<int> defaultBedNumbers = getDefaultBedNumbers(data);
      List<int> defaultRoomNumbers = getDefaultRoomNumbers(data);

      //As default in filterScreen, all beds and rooms are selected
      selectedBedsNumbers = defaultBedNumbers;
      selectedRoomsNumbers = defaultRoomNumbers;
      priceRange = RangeValues(data.minPrice!.toDouble(), data.maxPrice!.toDouble());
      defaultPriceRange = RangeValues(data.minPrice!.toDouble(), data.maxPrice!.toDouble());
      emit(state.copyWith(unitsFilterConfigData: data, rangeValues: priceRange, homeTypes: data.types));
    }
  }

  List<int> getDefaultBedNumbers(UnitFilterConfigEntity data) {
    var selectedBedsNumbers = List<int>.empty(growable: true);
    for (var i = 1; i <= data.maxBeds!; i++) {
      selectedBedsNumbers.add(i);
    }
    return selectedBedsNumbers;
  }

  List<int> getDefaultRoomNumbers(UnitFilterConfigEntity data) {
    var selectedRoomsNumbers = List<int>.empty(growable: true);
    for (var i = 1; i <= data.maxRooms!; i++) {
      selectedRoomsNumbers.add(i);
    }
    return selectedRoomsNumbers;
  }

  void initializeRegionData(Emitter<FilterState> emit, ApiResponse apiResponse) {
    if (apiResponse.data != null) {
      List<Region> regions = apiResponse.data.data;
      //As default in filterScreen, all regions and subRegions are selected
      setDefaultRegionsAndSubRegions(regions);
      emit(state.copyWith(regions: regions));
    }
  }

  FutureOr<void> _setRegions(SetRegion event, Emitter<FilterState> emit) {
    subRegionController.text = "";
    selectedRegionsToSubmit = event.regionList;
    selectedSubRegionsToSubmit = [];
    emit(state.copyWith(
      selectedRegions: event.regionList,
      selectedSubRegions: [],
      allRegionSelected: false,
    ));
  }

  List<Region> getSubRegionsByRegionIds(List<int> regionList) {
    List<Region> subRegions = List.empty(growable: true);
    state.regions?.asMap().forEach((key, region) {
      regionList.asMap().forEach((key, selectedRegion) {
        if (region.id == selectedRegion) {
          if (region.subRegions != null) {
            subRegions.addAll(region.subRegions!);
          }
        }
      });
    });
    return subRegions;
  }

  FutureOr<void> _setSubRegions(SetSubRegion event, Emitter<FilterState> emit) {
    selectedSubRegionsToSubmit = event.subRegionList.map((e) => e).toList();
    emit(state.copyWith(selectedSubRegions: event.subRegionList, allSubRegionSelected: false));
  }

  FutureOr<void> _setAllSubRegions(SetAllSubRegions event, Emitter<FilterState> emit) {
    selectedRegionsToSubmit = event.subRegionList.map((e) => e).toList();
    selectedSubRegionsToSubmit = [];
    emit(state.copyWith(selectedSubRegions: [], allSubRegionSelected: true));
  }

  void setDefaultRegionsAndSubRegions(List<Region> regions) {
    selectedRegionsToSubmit = regions.map((e) => e).toList();
  }

  FutureOr<void> _selectAllRegions(SelectAllRegions event, Emitter<FilterState> emit) {
    setDefaultRegionsAndSubRegions(state.regions!);
    selectedSubRegionsToSubmit = List.empty(growable: true);
    emit(state.copyWith(
        allRegionSelected: event.isAllRegionSelected,
        selectedRegions: List.empty(growable: true),
        selectedSubRegions: List.empty(growable: true)));
  }

  FutureOr<void> _selectAllRoomsNumbers(SelectAllRoomsNumbers event, Emitter<FilterState> emit) {
    List<int> selectedRoomsNumbers = List.empty(growable: true);
    if (event.isAllRoomsNumbersSelected) {
      event.roomsNumbers.asMap().forEach((key, value) {
        selectedRoomsNumbers.add(key);
      });
    }
    this.selectedRoomsNumbers = selectedRoomsNumbers;
    emit(state.copyWith(
        allRoomsNumbersSelected: event.isAllRoomsNumbersSelected, selectedRoomsNumbersList: List.empty()));
  }

  FutureOr<void> _selectAllBedsNumbers(SelectAllBedsNumbers event, Emitter<FilterState> emit) {
    List<int> selectedBedsNumbers = List.empty(growable: true);
    if (event.isAllBedsNumbersSelected) {
      event.bedsNumbers.asMap().forEach((key, value) {
        selectedBedsNumbers.add(key);
      });
    }
    this.selectedBedsNumbers = selectedBedsNumbers;
    emit(state.copyWith(allBedsNumbersSelected: event.isAllBedsNumbersSelected, selectedBedsNumbersList: List.empty()));
  }

  FutureOr<void> _apply(Apply event, Emitter<FilterState> emit) async {
    FilterQueries filterQueries = FilterQueries();
    filterQueries.regions = selectedSubRegionsToSubmit.isNotEmpty
        ? getSelectedSubRegionsAndSelectedRegionsThatHasNoSubRegions()
        : selectedRegionsToSubmit; //The Regions that will be queried are the selected subRegions and the selected regions with no subRegions
    filterQueries.minRooms = selectedRoomsNumbers;
    filterQueries.minBeds = selectedBedsNumbers;
    filterQueries.minPrice = priceRange!.start.toInt().toString();
    filterQueries.maxPrice = priceRange!.end.toInt().toString();
    filterQueries.mainRegionsOfSubRegions = selectedRegionsToSubmit;
    if (selectedHomeTypes.length == 1) {
      filterQueries.type = selectedHomeTypes[0];
    }
    handlePoppingToSearchScreen(filterQueries);
  }

  FutureOr<void> _reset(ResetFilterEvent event, Emitter<FilterState> emit) async {
    selectedSubRegionsToSubmit = [];
    selectedRegionsToSubmit = [];
    selectedRoomsNumbers = [];
    selectedBedsNumbers = [];
    selectedHomeTypes = [];
    priceRange = defaultPriceRange;
    emit(state.copyWith(
        allHomeTypesSelected: true,
        allBedsNumbersSelected: true,
        allRoomsNumbersSelected: true,
        allRegionSelected: true,
        selectedHomeTypes: const [],
        selectedRegions: const [],
        selectedSubRegions: const [],
        selectedRoomsNumbersList: const [],
        selectedBedsNumbersList: const [],
        rangeValues: RangeValues(
            state.unitsFilterConfigData!.minPrice!.toDouble(), state.unitsFilterConfigData!.maxPrice!.toDouble())));
  }

  FutureOr<void> _setFilterQueries(SetFilterQuery event, Emitter<FilterState> emit) async {
    //You have 2 situations; First one you coming with empty filters, the second one you come with filters

    //seperate regions Ids and subRegions ids coming from filterQueries
    List<Region> filterSelectedRegions = List.empty(growable: true);
    List<Region> filterSelectedSubRegions = List.empty(growable: true);
    FilterBlocUtils.separateRegionsAndSubRegionsIds(
        event.filterQueries!, filterSelectedRegions, filterSelectedSubRegions, state.regions!);

    RangeValues priceRange =
        RangeValues(getMinPrice(event.filterQueries!.minPrice), getMaxPrice(event.filterQueries!.maxPrice));
    this.priceRange = priceRange;

    bool allBedsNumbersSelected = checkSelectionsOfAllBeds(event.filterQueries!);

    bool allRoomsNumbersSelected = checkSelectionOfAllRooms(event.filterQueries!);
    bool allTypesSelected = checkSelectionOfAllTypes(event.filterQueries!);

    bool allRegionsSelected = (filterSelectedRegions.length == state.regions!.length) ||
        (filterSelectedRegions.isEmpty && filterSelectedSubRegions.isEmpty);
    bool allSubRegionSelected = filterSelectedSubRegions.isEmpty;

    // set all regions selected in case of coming from search screen with selected subregions that selected from search screen bottom sheet
    if (event.filterQueries?.isComingFromSearchScreenWithSubRegions ?? false) {
      allRegionsSelected = true;
    }

    if (!allRegionsSelected && !allSubRegionSelected) {
      //this means some subregions is selected so we set regions as their main regions
      filterSelectedRegions = event.filterQueries?.mainRegionsOfSubRegions ?? [];
      selectedRegionsToSubmit = filterSelectedRegions;
      if (event.filterQueries?.mainRegionsOfSubRegions.length == state.regions?.length) {
        allRegionsSelected = true;
      }
    }

    if (!allRegionsSelected) {
      //If all Regions are not Selected So You need to Add The Coming filterSelectedRegions to the selectedRegionIds
      selectedRegionsToSubmit = filterSelectedRegions;
    }

    if (!allSubRegionSelected) {
      //If not all SubRegions are not Selected So You need to Add The Coming filterSelectedSubRegions to the selectedSubRegionsIds
      selectedSubRegionsToSubmit = filterSelectedSubRegions;
    }

    emit(FilterState(
        selectedRegions: allRegionsSelected ? List.empty() : filterSelectedRegions,
        selectedSubRegions: allSubRegionSelected ? List.empty() : filterSelectedSubRegions,
        rangeValues: priceRange,
        allBedsNumbersSelected: allBedsNumbersSelected,
        allRoomsNumbersSelected: allRoomsNumbersSelected,
        allHomeTypesSelected: allTypesSelected,
        allRegionSelected: allRegionsSelected,
        allSubRegionSelected: allSubRegionSelected,
        unitsFilterConfigData: state.unitsFilterConfigData,
        regions: state.regions,
        selectedHomeTypes: seHomeTypes(allTypesSelected, event.filterQueries!),
        selectedRoomsNumbers: setRoomsNumbers(allRoomsNumbersSelected, event.filterQueries!),
        selectedBedsNumbers: setBedsNumbers(allBedsNumbersSelected, event.filterQueries!),
        subRegions: getSubRegionsByRegionIds(filterSelectedRegions.map((e) => e.id!).toList())));
  }

  bool setAllRegionsSelectedWhenComingFromSearchScreenWithSubRegions(SetFilterQuery event, bool allRegionsSelected) {
    if (event.filterQueries?.isComingFromSearchScreenWithSubRegions ?? false) {
      bool isAParentRegionSelected = false;
      event.filterQueries?.regions.forEach((selectedRegion) {
        state.regions?.forEach((region) {
          if (region.id == selectedRegion.id) {
            isAParentRegionSelected = true;
          }
        });
      });
      if (!isAParentRegionSelected) {
        allRegionsSelected = true;
      }
    }
    return allRegionsSelected;
  }

  List<int> setRoomsNumbers(bool allRoomsNumbersSelected, FilterQueries filterQueries) {
    List<int> roomsNumbers = List.empty(growable: true);
    if (!allRoomsNumbersSelected) {
      filterQueries.minRooms.forEach((element) {
        roomsNumbers.add(element);
      });
      selectedRoomsNumbers = roomsNumbers;
    }
    return roomsNumbers;
  }

  List<String> seHomeTypes(bool allHomeTypesIsSelected, FilterQueries filterQueries) {
    List<String> homeTypes = List.empty(growable: true);
    if (!allHomeTypesIsSelected) {
      homeTypes.add(
          state.unitsFilterConfigData!.types!.where((element) => element.value == filterQueries.type).first.value!);
    }
    return homeTypes;
  }

  List<int> setBedsNumbers(bool allBedsNumbersSelected, FilterQueries filterQueries) {
    List<int> bedsNumbers = List.empty(growable: true);
    if (!allBedsNumbersSelected) {
      filterQueries.minBeds.forEach((element) {
        bedsNumbers.add(element);
      });
      selectedBedsNumbers = bedsNumbers;
    }
    return bedsNumbers;
  }

  bool checkSelectionOfAllRooms(FilterQueries filterQueries) {
    bool allRoomsNumbersSelected =
        filterQueries.minRooms.length == state.unitsFilterConfigData!.maxRooms || filterQueries.minRooms.isEmpty;
    return allRoomsNumbersSelected;
  }

  bool checkSelectionOfAllTypes(FilterQueries filterQueries) {
    bool allTypesSelected = filterQueries.type == "";
    return allTypesSelected;
  }

  bool checkSelectionsOfAllBeds(FilterQueries filterQueries) {
    bool allBedsNumbersSelected =
        filterQueries.minBeds.length == state.unitsFilterConfigData!.maxBeds || filterQueries.minBeds.isEmpty;
    return allBedsNumbersSelected;
  }

  double getMinPrice(String minPrice) =>
      minPrice.isNotEmpty ? double.parse(minPrice) : state.unitsFilterConfigData!.minPrice!.toDouble();
  double getMaxPrice(String maxPrice) =>
      maxPrice.isNotEmpty ? double.parse(maxPrice) : state.unitsFilterConfigData!.maxPrice!.toDouble();

  void handlePoppingToSearchScreen(FilterQueries filterQueries) async {
    navigationKey.currentState?.pop(filterQueries);
  }

  List<Region> getSelectedSubRegionsAndSelectedRegionsThatHasNoSubRegions() {
    List<Region>? regionsWithoutSubregions = state.regions?.where((element) => !element.hasSubRegion!).toList();
    List<Region>? selectedRegionsWithoutSubregions = List.empty(growable: true);
    if (regionsWithoutSubregions != null) {
      for (var regionWithoutSubRegion in regionsWithoutSubregions) {
        for (var selectedRegion in selectedRegionsToSubmit) {
          if (regionWithoutSubRegion.id == selectedRegion.id) {
            selectedRegionsWithoutSubregions.add(selectedRegion);
          }
        }
      }
    }
    List<Region> selectedSubRegionsAndSelectedRegionsThatHasNoSubRegions = List.empty(growable: true);
    for (var element in selectedSubRegionsToSubmit) {
      selectedSubRegionsAndSelectedRegionsThatHasNoSubRegions.add(element);
    }

    for (var element in selectedRegionsWithoutSubregions) {
      selectedSubRegionsAndSelectedRegionsThatHasNoSubRegions.add(element);
    }

    return selectedSubRegionsAndSelectedRegionsThatHasNoSubRegions;
  }
}