import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/add_reservation_screen/models/add_reservation_config.dart';

import '../../../../../../../../data/remote/region/model/get_regions_response_entity.dart';

abstract class AddReservationEvent extends Equatable {
  const AddReservationEvent();
}

class GetRegions extends AddReservationEvent {
  final AddReservationConfig? config;
  const GetRegions(this.config);

  @override
  List<Object?> get props => [config];
}

class SetRegionEvent extends AddReservationEvent {
  final Region selectedRegion;
  const SetRegionEvent(this.selectedRegion);

  @override
  List<Object?> get props => [selectedRegion];
}

class GetUnits extends AddReservationEvent {
  const GetUnits();

  @override
  List<Object?> get props => [];
}

class SetUnitEvent extends AddReservationEvent {
  final Unit selectedUnit;
  const SetUnitEvent(this.selectedUnit);

  @override
  List<Object?> get props => [selectedUnit];
}

class PostReservationEvent extends AddReservationEvent {
  const PostReservationEvent();
  @override
  List<Object?> get props => [];
}

class HideError extends AddReservationEvent {
  const HideError();
  @override
  List<Object?> get props => [];
}

class AddStartDateEvent extends AddReservationEvent {
  final DateTime startDate;
  final String startDateString;
  const AddStartDateEvent(this.startDate, this.startDateString);

  @override
  List<Object?> get props => [startDate, startDateString];
}

class AddEndDateEvent extends AddReservationEvent {
  final DateTime endDate;
  final String endDateString;
  const AddEndDateEvent(this.endDate, this.endDateString);

  @override
  List<Object?> get props => [endDate, endDateString];
}
