import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/reservation/model/get_reservations_response_entity.dart';

class ReservationDetailsRentedState extends Equatable {
  const ReservationDetailsRentedState({this.isLoading = false, this.reservation});
  final bool isLoading;
  final Reservation? reservation;
  @override
  List<Object?> get props => [isLoading, reservation];

  ReservationDetailsRentedState copyWith({bool? isLoading, Reservation? reservation}) {
    return ReservationDetailsRentedState(
        isLoading: isLoading ?? this.isLoading, reservation: reservation ?? this.reservation);
  }
}

class InitialReservationDetailsRentedState extends ReservationDetailsRentedState {
  const InitialReservationDetailsRentedState() : super();
}
