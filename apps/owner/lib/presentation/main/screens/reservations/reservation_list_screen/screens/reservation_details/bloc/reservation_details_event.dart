import 'package:equatable/equatable.dart';

abstract class ReservationDetailsEvent extends Equatable {}

class GetReservation extends ReservationDetailsEvent {
  final String reservationId;

  GetReservation(this.reservationId);

  @override
  List<Object?> get props => [reservationId];
}

class ApproveReservationEvent extends ReservationDetailsEvent {
  ApproveReservationEvent();

  @override
  List<Object?> get props => [];
}

class RejectReservationEvent extends ReservationDetailsEvent {
  RejectReservationEvent();

  @override
  List<Object?> get props => [];
}
