import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';

class EditUnitThirdState extends Equatable {
  EditUnitThirdState({
    this.regions,
    this.subRegions,
    this.isGetRegionsAndSubRegionsApiError = false,
    this.selectedRegion,
    this.selectedSubRegion,
    this.roomNumber = 1,
    this.bedNumber = 1,
    this.bathNumber = 1,
    this.guestsNumber = 5,
    this.hideSubRegionsSection = false,
    this.unit,
    this.checkOut,
    this.checkIn,
    this.isSubRegionsLoading = false,
    this.hasMoreSubRegions,
    this.isRegionsLoading = false,
    this.isLoading = false
  });
  final List<Region>? regions;
  final List<Region>? subRegions;
  final bool isGetRegionsAndSubRegionsApiError;
  final Region? selectedRegion;
  Region? selectedSubRegion;
  final int roomNumber;
  final int bedNumber;
  final int bathNumber;
  final int guestsNumber;
  final Unit? unit;
  final bool hideSubRegionsSection;
  final TimeOfDay? checkIn;
  final TimeOfDay? checkOut;
  final bool? isSubRegionsLoading;
  final bool? isRegionsLoading;
  final bool? hasMoreSubRegions;
  final bool isLoading;

  @override
  List<Object?> get props => [
    regions,
    subRegions,
    isGetRegionsAndSubRegionsApiError,
    selectedRegion,
    selectedSubRegion,
    roomNumber,
    bedNumber,
    bathNumber,
    guestsNumber,
    unit,
    hideSubRegionsSection,
    checkOut,
    checkIn,
    isSubRegionsLoading,
    hasMoreSubRegions,
    isRegionsLoading,
    isLoading
  ];

  EditUnitThirdState copyWith(
      {List<Region>? regions,
      List<Region>? subRegions,
      bool isGetRegionsAndSubRegionsApiError = false,
      Region? selectedRegion,
      Region? selectedSubRegion,
      int? roomNumber,
      int? bedNumber,
      int? bathNumber,
      int? guestsNumber,
      bool? hideSubRegionsSection,
      Unit? unit,
      TimeOfDay? checkIn,
      TimeOfDay? checkOut,
      bool? isSubRegionsLoading,
      bool? isRegionsLoading,
      bool? hasMoreSubRegions,
      bool? isLoading}) {
    return EditUnitThirdState(
        roomNumber: roomNumber ?? this.roomNumber,
        bedNumber: bedNumber ?? this.bedNumber,
        regions: regions ?? this.regions,
        subRegions: subRegions ?? this.subRegions,
        isGetRegionsAndSubRegionsApiError: isGetRegionsAndSubRegionsApiError,
        selectedRegion: selectedRegion ?? this.selectedRegion,
        selectedSubRegion: selectedSubRegion ?? this.selectedSubRegion,
        bathNumber: bathNumber ?? this.bathNumber,
        guestsNumber: guestsNumber ?? this.guestsNumber,
        unit: unit ?? this.unit,
        hideSubRegionsSection: hideSubRegionsSection ?? this.hideSubRegionsSection,
        checkIn: checkIn ?? this.checkIn,
        checkOut: checkOut ?? this.checkOut,
        isSubRegionsLoading: isSubRegionsLoading ?? this.isSubRegionsLoading,
        hasMoreSubRegions: hasMoreSubRegions ?? this.hasMoreSubRegions,
        isRegionsLoading: isRegionsLoading ?? this.isRegionsLoading,
        isLoading: isLoading ?? this.isLoading
    );
  }
}

class EditUnitThirdEmptyState extends EditUnitThirdState {
  EditUnitThirdEmptyState() : super();
}
