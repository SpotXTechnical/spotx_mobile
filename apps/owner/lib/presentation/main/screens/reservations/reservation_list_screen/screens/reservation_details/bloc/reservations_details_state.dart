import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';

class ReservationDetailsState extends Equatable {
  const ReservationDetailsState({this.isLoading = false, this.reservation});
  final bool isLoading;
  final Reservation? reservation;
  @override
  List<Object?> get props => [isLoading, reservation];

  ReservationDetailsState copyWith({bool? isLoading, Reservation? reservation}) {
    return ReservationDetailsState(
        isLoading: isLoading ?? this.isLoading, reservation: reservation ?? this.reservation);
  }
}
