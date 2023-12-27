import 'package:equatable/equatable.dart';

abstract class ReservationDetailsRentedEvent extends Equatable {}

class GetReservation extends ReservationDetailsRentedEvent {
  final String reservationId;

  GetReservation(this.reservationId);

  @override
  List<Object?> get props => [reservationId];
}
