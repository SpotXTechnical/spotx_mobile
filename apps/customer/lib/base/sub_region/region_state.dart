import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';

class RegionState extends Equatable {
  RegionState(
      {this.regions,
      this.hasMoreRegions = false,
      this.isLoading = false,
      this.isError = false,
      this.selectedRegions,
      this.isAllSelected = true});
  final List<Region>? regions;
  final bool hasMoreRegions;
  final bool isLoading;
  final bool isError;
  final List<Region>? selectedRegions;
  final bool isAllSelected;

  @override
  List<Object?> get props => [regions, hasMoreRegions, isError, selectedRegions, isLoading, isAllSelected];

  RegionState copyWith(
      {List<Region>? regions,
      bool? hasMoreRegions,
      bool? isLoading,
      bool? isError,
      List<Region>? selectedRegions,
      bool? isAllSelected}) {
    return RegionState(
        regions: regions ?? this.regions,
        hasMoreRegions: hasMoreRegions ?? this.hasMoreRegions,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        selectedRegions: selectedRegions ?? this.selectedRegions,
        isAllSelected: isAllSelected ?? this.isAllSelected);
  }
}
