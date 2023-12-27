import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/edit_unit_second_screen/bloc/edit_unit_second_state.dart';

class AddCampSecondState extends Equatable {
  AddCampSecondState(
      {this.regions,
      this.subRegions,
      this.isGetRegionsAndSubRegionsApiError = false,
      this.selectedRegion,
      this.selectedSubRegion,
      this.files,
      this.imageError,
      this.hideSubRegionsSection = false,
      this.checkOut,
      this.checkIn,
      this.isPublished = true,
      this.isLoading = false,
      this.isSubRegionsLoading = false});
  final List<Region>? regions;
  final List<Region>? subRegions;
  final bool isGetRegionsAndSubRegionsApiError;
  final Region? selectedRegion;
  Region? selectedSubRegion;
  final ImageError? imageError;
  final List<MediaFile>? files;
  final bool hideSubRegionsSection;
  final TimeOfDay? checkIn;
  final TimeOfDay? checkOut;
  final bool isLoading;
  final bool isPublished;
  final bool isSubRegionsLoading;

  @override
  List<Object?> get props => [
        regions,
        subRegions,
        isGetRegionsAndSubRegionsApiError,
        selectedRegion,
        selectedSubRegion,
        imageError,
        files,
        hideSubRegionsSection,
        checkOut,
        checkIn,
        isLoading,
        isSubRegionsLoading
      ];

  AddCampSecondState copyWith(
      {List<Region>? regions,
      List<Region>? subRegions,
      bool isGetRegionsAndSubRegionsApiError = false,
      Region? selectedRegion,
      Region? selectedSubRegion,
      List<MediaFile>? files,
      ImageError? imageError,
      bool? hideSubRegionsSection,
      TimeOfDay? checkIn,
      TimeOfDay? checkOut,
      bool? isPublished,
      bool? isLoading,
      bool? isSubRegionsLoading}) {
    return AddCampSecondState(
        regions: regions ?? this.regions,
        subRegions: subRegions ?? this.subRegions,
        isGetRegionsAndSubRegionsApiError: isGetRegionsAndSubRegionsApiError,
        selectedRegion: selectedRegion ?? this.selectedRegion,
        selectedSubRegion: selectedSubRegion ?? this.selectedSubRegion,
        files: files ?? this.files,
        imageError: imageError ?? this.imageError,
        hideSubRegionsSection: hideSubRegionsSection ?? this.hideSubRegionsSection,
        checkIn: checkIn ?? this.checkIn,
        checkOut: checkOut ?? this.checkOut,
        isLoading: isLoading ?? this.isLoading,
        isPublished: isPublished ?? this.isPublished,
        isSubRegionsLoading: isSubRegionsLoading ?? this.isSubRegionsLoading);
  }
}

class AddCampSecondEmptyState extends AddCampSecondState {
  AddCampSecondEmptyState() : super();
}
