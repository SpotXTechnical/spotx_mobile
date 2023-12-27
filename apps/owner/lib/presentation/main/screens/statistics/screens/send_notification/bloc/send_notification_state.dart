import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';

class SendNotificationState extends Equatable {
  const SendNotificationState(
      {this.selectedRegionId,
      this.regions,
      this.units,
      this.isRegionLoading = false,
      this.isUnitsLoading = false,
      this.selectedUnit,
      this.hasUnit = false,
      this.isLoading = false,
      this.isAllRegionsSelected = true,
      this.isAllUnitsSelected = true});
  final int? selectedRegionId;
  final List<Region>? regions;
  final bool isRegionLoading;
  final bool isUnitsLoading;
  final List<Unit>? units;
  final Unit? selectedUnit;
  final bool hasUnit;
  final bool isLoading;
  final bool isAllRegionsSelected;
  final bool isAllUnitsSelected;

  @override
  List<Object?> get props => [
        selectedRegionId,
        regions,
        units,
        isUnitsLoading,
        isRegionLoading,
        selectedUnit,
        hasUnit,
        isLoading,
        isAllRegionsSelected,
        isAllUnitsSelected
      ];

  SendNotificationState copyWith(
      {int? selectedRegionId,
      List<Region>? regions,
      List<Unit>? units,
      bool? isRegionLoading,
      bool? isUnitsLoading,
      Unit? selectedUnit,
      bool? hasUnit,
      bool? isLoading,
      bool? isAllRegionsSelected,
      bool? isAllUnitsSelected}) {
    return SendNotificationState(
        selectedRegionId: selectedRegionId ?? this.selectedRegionId,
        regions: regions ?? this.regions,
        units: units ?? this.units,
        isRegionLoading: isRegionLoading ?? this.isRegionLoading,
        isUnitsLoading: isUnitsLoading ?? this.isUnitsLoading,
        selectedUnit: selectedUnit ?? this.selectedUnit,
        hasUnit: hasUnit ?? this.hasUnit,
        isLoading: isLoading ?? this.isLoading,
        isAllUnitsSelected: isAllUnitsSelected ?? this.isAllUnitsSelected,
        isAllRegionsSelected: isAllRegionsSelected ?? this.isAllRegionsSelected);
  }
}
