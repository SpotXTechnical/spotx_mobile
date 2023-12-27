import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';

class AddUnitThirdState extends Equatable {
  AddUnitThirdState({
    this.regions,
    this.subRegions,
    this.isGetRegionsAndSubRegionsApiError = false,
    this.selectedRegion,
    this.selectedSubRegion,
    this.roomNumber = 1,
    this.bedNumber = 1,
    this.bathNumber = 1,
    this.hideSubRegionsSection = false,
    this.checkOut = const TimeOfDay(hour: 10, minute: 0),
    this.checkIn = const TimeOfDay(hour: 12, minute: 0),
    this.isSubRegionsLoading = false,
    this.guestsNumber = 5
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
  final bool hideSubRegionsSection;
  final TimeOfDay? checkIn ;
  final TimeOfDay? checkOut;
  final bool? isSubRegionsLoading;

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
    hideSubRegionsSection,
    checkOut,
    checkIn,
    isSubRegionsLoading,
    guestsNumber
  ];

  AddUnitThirdState copyWith({
    List<Region>? regions,
    List<Region>? subRegions,
    bool isGetRegionsAndSubRegionsApiError = false,
    Region? selectedRegion,
    Region? selectedSubRegion,
    int? roomNumber,
    int? bedNumber,
    int? bathNumber,
    int? guestsNumber,
    bool? hideSubRegionsSection,
    TimeOfDay? checkIn,
    TimeOfDay? checkOut,
    bool? isSubRegionsLoading
  }) {
    return AddUnitThirdState(
      roomNumber: roomNumber ?? this.roomNumber,
      bedNumber: bedNumber ?? this.bedNumber,
      regions: regions ?? this.regions,
      subRegions: subRegions ?? this.subRegions,
      isGetRegionsAndSubRegionsApiError: isGetRegionsAndSubRegionsApiError,
      selectedRegion: selectedRegion ?? this.selectedRegion,
      selectedSubRegion: selectedSubRegion ?? this.selectedSubRegion,
      bathNumber: bathNumber ?? this.bathNumber,
      hideSubRegionsSection: hideSubRegionsSection ?? this.hideSubRegionsSection,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      isSubRegionsLoading: isSubRegionsLoading ?? this.isSubRegionsLoading,
      guestsNumber: guestsNumber ?? this.guestsNumber
    );
  }
}

class AddUnitThirdEmptyState extends AddUnitThirdState {
  AddUnitThirdEmptyState() : super();
}
