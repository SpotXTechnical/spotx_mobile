import 'package:equatable/equatable.dart';

abstract class ReservationDetailsPendingEvent extends Equatable {}

class GetReservation extends ReservationDetailsPendingEvent {
  final String reservationId;

  GetReservation(this.reservationId);

  @override
  List<Object?> get props => [reservationId];
}

class CancelReservation extends ReservationDetailsPendingEvent {
  final String reservationId;

  CancelReservation(this.reservationId);

  @override
  List<Object?> get props => [reservationId];
}

class ReservationCheckIfUserIsLoggedInEvent extends ReservationDetailsPendingEvent {
  final String? reservationId;
  ReservationCheckIfUserIsLoggedInEvent(this.reservationId);

  @override
  List<Object?> get props => [reservationId];
}
