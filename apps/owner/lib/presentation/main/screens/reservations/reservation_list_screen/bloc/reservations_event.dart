import 'package:equatable/equatable.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/bloc/reservations_state.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/model/reservations_calender_config.dart';

abstract class ReservationsEvent extends Equatable {
  const ReservationsEvent();
}

class GetReservationsByPastOrUpcomingEvent extends ReservationsEvent {
  final int upcoming;
  final int past;
  final SelectedReservationsType selectedReservationsType;
  const GetReservationsByPastOrUpcomingEvent(this.upcoming, this.past, this.selectedReservationsType);

  @override
  List<Object?> get props => [upcoming, past, selectedReservationsType];
}

class GetReservationsByMonth extends ReservationsEvent {
  final ReservationsCalenderConfig config;
  final DateTime date;
  const GetReservationsByMonth(this.config, this.date);

  @override
  List<Object?> get props => [config, date];
}

class LoadMoreReservations extends ReservationsEvent {
  final int upcoming;
  final int past;
  final SelectedReservationsType selectedRentType;
  const LoadMoreReservations(this.upcoming, this.past, this.selectedRentType);

  @override
  List<Object?> get props => [upcoming, past, selectedRentType];
}

class ApproveReservationEvent extends ReservationsEvent {
  final String reservationId;
  const ApproveReservationEvent(this.reservationId);

  @override
  List<Object?> get props => [reservationId];
}

class RejectReservationEvent extends ReservationsEvent {
  final String reservationId;
  const RejectReservationEvent(this.reservationId);

  @override
  List<Object?> get props => [reservationId];
}

class ChangeShowType extends ReservationsEvent {
  const ChangeShowType();

  @override
  List<Object?> get props => [];
}

class GetUnits extends ReservationsEvent {
  const GetUnits();

  @override
  List<Object?> get props => [];
}

class InitScrollController extends ReservationsEvent {
  const InitScrollController();

  @override
  List<Object?> get props => [];
}
