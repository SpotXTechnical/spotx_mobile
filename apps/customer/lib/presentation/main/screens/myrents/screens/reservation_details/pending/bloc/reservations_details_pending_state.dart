import 'package:equatable/equatable.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/reservation/model/get_reservations_response_entity.dart';

class ReservationDetailsPendingState extends Equatable {
  const ReservationDetailsPendingState(
      {this.requestStatus = RequestStatus.loading,
      this.reservation,
      this.isAuthorized = false,
      this.showUnAuthorizedWidget = false,
      this.isReservationDataValid = true});
  final RequestStatus requestStatus;
  final Reservation? reservation;
  final bool isAuthorized;
  final bool showUnAuthorizedWidget;
  final bool isReservationDataValid;
  @override
  List<Object?> get props => [requestStatus, reservation, isAuthorized, showUnAuthorizedWidget, isReservationDataValid];

  ReservationDetailsPendingState copyWith(
      {RequestStatus? requestStatus, Reservation? reservation, bool? isAuthorized, bool? showUnAuthorizedWidget, bool? isReservationDataValid}) {
    return ReservationDetailsPendingState(
        requestStatus: requestStatus ?? this.requestStatus,
        reservation: reservation ?? this.reservation,
        isAuthorized: isAuthorized ?? this.isAuthorized,
        showUnAuthorizedWidget: showUnAuthorizedWidget ?? this.showUnAuthorizedWidget,
        isReservationDataValid: isReservationDataValid ?? this.isReservationDataValid);
  }
}
