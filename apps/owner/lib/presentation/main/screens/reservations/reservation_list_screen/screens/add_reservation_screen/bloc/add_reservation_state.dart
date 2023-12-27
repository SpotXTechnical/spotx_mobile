import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/add_reservation_screen/models/add_reservation_config.dart';

class AddReservationState extends Equatable {
  const AddReservationState(
      {this.selectedRegion,
      this.regions,
      this.units,
      this.isRegionLoading = false,
      this.isUnitsLoading = false,
      this.addReservationConfig,
      this.hasUnit = true,
      this.isLoading = false,
      this.startDate,
      this.endDate});
  final Region? selectedRegion;
  final List<Region>? regions;
  final bool isRegionLoading;
  final bool isUnitsLoading;
  final List<Unit>? units;
  final AddReservationConfig? addReservationConfig;
  final bool hasUnit;
  final bool isLoading;
  final DateTime? startDate;
  final DateTime? endDate;

  @override
  List<Object?> get props => [
        selectedRegion,
        regions,
        units,
        isUnitsLoading,
        isRegionLoading,
        addReservationConfig,
        hasUnit,
        isLoading,
        startDate,
        endDate
      ];

  AddReservationState copyWith(
      {Region? selectedRegion,
      List<Region>? regions,
      List<Unit>? units,
      bool? isRegionLoading,
      bool? isUnitsLoading,
      AddReservationConfig? addReservationConfig,
      bool? hasUnit,
      bool? isLoading,
      DateTime? startDate,
      DateTime? endDate}) {
    return AddReservationState(
        selectedRegion: selectedRegion ?? this.selectedRegion,
        regions: regions ?? this.regions,
        units: units ?? this.units,
        isRegionLoading: isRegionLoading ?? this.isRegionLoading,
        isUnitsLoading: isUnitsLoading ?? this.isUnitsLoading,
        addReservationConfig: addReservationConfig ?? this.addReservationConfig,
        hasUnit: hasUnit ?? this.hasUnit,
        isLoading: isLoading ?? this.isLoading,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate);
  }
}
