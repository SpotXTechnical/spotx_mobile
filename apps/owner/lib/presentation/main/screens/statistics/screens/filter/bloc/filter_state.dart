import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';

class FilterState extends Equatable {
  const FilterState(
      {this.selectedRegion,
      this.regions,
      this.units,
      this.isRegionLoading = false,
      this.isUnitsLoading = false,
      this.selectedUnit,
      this.startDate,
      this.endDate,
      this.hasUnit = true,
      this.isFromFilter = false});
  final Region? selectedRegion;
  final List<Region>? regions;
  final bool isRegionLoading;
  final bool isUnitsLoading;
  final List<Unit>? units;
  final Unit? selectedUnit;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool hasUnit;
  final bool isFromFilter;

  @override
  List<Object?> get props => [
        selectedRegion,
        regions,
        units,
        isUnitsLoading,
        isRegionLoading,
        selectedUnit,
        startDate,
        endDate,
        hasUnit,
        isFromFilter
      ];

  FilterState copyWith(
      {Region? selectedRegion,
      List<Region>? regions,
      List<Unit>? units,
      bool? isRegionLoading,
      bool? isUnitsLoading,
      Unit? selectedUnit,
      DateTime? startDate,
      DateTime? endDate,
      bool? hasUnit,
      bool? isFromFilter}) {
    return FilterState(
        selectedRegion: selectedRegion ?? this.selectedRegion,
        regions: regions ?? this.regions,
        units: units ?? this.units,
        isRegionLoading: isRegionLoading ?? this.isRegionLoading,
        isUnitsLoading: isUnitsLoading ?? this.isUnitsLoading,
        selectedUnit: selectedUnit ?? this.selectedUnit,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        hasUnit: hasUnit ?? this.hasUnit,
        isFromFilter: isFromFilter ?? this.isFromFilter);
  }
}
