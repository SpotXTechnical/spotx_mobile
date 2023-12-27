import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/data/remote/unit/model/unit_filter_config_entity.dart';

class FilterState extends Equatable {
  final List<String> selectedHomeTypes;
  final List<Region> selectedRegions;
  final List<Region>? selectedSubRegions;
  final List<int> selectedRoomsNumbers;
  final List<int> selectedBedsNumbers;
  final RangeValues? rangeValues;
  final UnitFilterConfigEntity? unitsFilterConfigData;
  final List<Region>? regions;
  final List<Region>? subRegions;
  final List<UnitFilterConfigTypes>? homeTypes;
  final bool allRegionSelected;
  final bool allSubRegionSelected;
  final bool allBedsNumbersSelected;
  final bool allRoomsNumbersSelected;
  final bool allHomeTypesSelected;
  final bool isGetRegionsAndSubRegionsApiError;
  final bool isGetUnitFilterConfigDataApiError;
  final bool hideSubRegionSection;
  const FilterState(
      {this.selectedHomeTypes = const [],
      this.selectedRegions = const [],
      this.selectedRoomsNumbers = const [],
      this.selectedBedsNumbers = const [],
      this.rangeValues,
      this.unitsFilterConfigData,
      this.regions,
      this.homeTypes,
      this.subRegions,
      this.allRegionSelected = true,
      this.allSubRegionSelected = true,
      this.allBedsNumbersSelected = true,
      this.allRoomsNumbersSelected = true,
      this.allHomeTypesSelected = true,
      this.isGetRegionsAndSubRegionsApiError = false,
      this.isGetUnitFilterConfigDataApiError = false,
      this.hideSubRegionSection = false,
      this.selectedSubRegions = const []});

  @override
  List<Object?> get props => [
        selectedHomeTypes,
        selectedRegions,
        selectedRoomsNumbers,
        selectedBedsNumbers,
        rangeValues,
        unitsFilterConfigData,
        regions,
        homeTypes,
        subRegions,
        allRegionSelected,
        allSubRegionSelected,
        allBedsNumbersSelected,
        allRoomsNumbersSelected,
        allHomeTypesSelected,
        isGetUnitFilterConfigDataApiError,
        isGetRegionsAndSubRegionsApiError,
        hideSubRegionSection,
        selectedSubRegions
      ];

  FilterState copyWith(
      {List<String>? selectedHomeTypes,
      List<Region>? selectedRegions,
      List<int>? selectedRoomsNumbersList,
      List<int>? selectedBedsNumbersList,
      RangeValues? rangeValues,
      UnitFilterConfigEntity? unitsFilterConfigData,
      List<Region>? regions,
      List<Region>? subRegions,
      bool? allRegionSelected,
      bool? allSubRegionSelected,
      bool? allBedsNumbersSelected,
      bool? allRoomsNumbersSelected,
      bool? allHomeTypesSelected,
      bool? isGetUnitFilterConfigDataApiError,
      bool? isGetRegionsAndSubRegionsApiError,
      bool? hideSubRegionSection,
      List<UnitFilterConfigTypes>? homeTypes,
      List<Region>? selectedSubRegions}) {
    return FilterState(
        selectedHomeTypes: selectedHomeTypes ?? this.selectedHomeTypes,
        selectedRegions: selectedRegions ?? this.selectedRegions,
        selectedRoomsNumbers: selectedRoomsNumbersList ?? this.selectedRoomsNumbers,
        selectedBedsNumbers: selectedBedsNumbersList ?? this.selectedBedsNumbers,
        rangeValues: rangeValues ?? this.rangeValues,
        unitsFilterConfigData: unitsFilterConfigData ?? this.unitsFilterConfigData,
        regions: regions ?? this.regions,
        subRegions: subRegions ?? this.subRegions,
        allRegionSelected: allRegionSelected ?? this.allRegionSelected,
        allSubRegionSelected: allSubRegionSelected ?? this.allSubRegionSelected,
        allBedsNumbersSelected: allBedsNumbersSelected ?? this.allBedsNumbersSelected,
        allRoomsNumbersSelected: allRoomsNumbersSelected ?? this.allRoomsNumbersSelected,
        allHomeTypesSelected: allHomeTypesSelected ?? this.allHomeTypesSelected,
        isGetRegionsAndSubRegionsApiError: isGetRegionsAndSubRegionsApiError ?? this.isGetRegionsAndSubRegionsApiError,
        isGetUnitFilterConfigDataApiError: isGetUnitFilterConfigDataApiError ?? this.isGetUnitFilterConfigDataApiError,
        hideSubRegionSection: hideSubRegionSection ?? this.hideSubRegionSection,
        homeTypes: homeTypes ?? this.homeTypes,
        selectedSubRegions: selectedSubRegions ?? this.selectedSubRegions);
  }
}
