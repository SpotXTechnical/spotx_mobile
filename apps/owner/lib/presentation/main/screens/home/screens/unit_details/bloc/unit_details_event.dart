import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/bloc/unit_details_state.dart';

import '../../../../../../../data/remote/add_unit/model/unit.dart';

abstract class UnitDetailsEvent extends Equatable {}

class GetUnitDetails extends UnitDetailsEvent {
  final String id;
  GetUnitDetails(this.id);

  @override
  List<Object?> get props => [id];
}

class UnitDetailsSetUnit extends UnitDetailsEvent {
  final Unit unit;
  UnitDetailsSetUnit(this.unit);

  @override
  List<Object?> get props => [unit];
}

class SetSelectedContentTypeEvent extends UnitDetailsEvent {
  final SelectedContentType selectedContentType;
  SetSelectedContentTypeEvent(this.selectedContentType);

  @override
  List<Object?> get props => [selectedContentType];
}

class SetSelectedRoom extends UnitDetailsEvent {
  final Room selectedRoom;
  SetSelectedRoom(this.selectedRoom);

  @override
  List<Object?> get props => [selectedRoom];
}

class GetRoomsEvent extends UnitDetailsEvent {
  GetRoomsEvent();

  @override
  List<Object?> get props => [];
}


class ApproveReservationEvent extends UnitDetailsEvent {
  ApproveReservationEvent(this.reservation);

  final Reservation reservation;

  @override
  List<Object?> get props => [reservation];
}

class RejectReservationEvent extends UnitDetailsEvent {
  RejectReservationEvent(this.reservation);

  final Reservation reservation;

  @override
  List<Object?> get props => [reservation];
}

class CancelReservationEvent extends UnitDetailsEvent {
  CancelReservationEvent(this.reservation, this.isReservedByQuest);

  final Reservation reservation;
  final bool isReservedByQuest;

  @override
  List<Object?> get props => [reservation, isReservedByQuest];
}

class PostReservationEvent extends UnitDetailsEvent {
  PostReservationEvent(this.day);

  final DateTime day;

  @override
  List<Object?> get props => [day];
}