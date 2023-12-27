import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/reservation/model/get_reservations_response_entity.dart';

import '../../../../../base/base_bloc.dart';

class MyRentsState extends Equatable {
  const MyRentsState(
      {this.upComingReservationsList,
      this.isAuthorized = false,
      this.upComingHasMore = false,
      this.showUnAuthorizedWidget = false,
      this.selectedRentType = SelectedRentType.upComing,
      this.upComingRequestStatus = RequestStatus.loading,
      this.pastRequestStatus = RequestStatus.loading,
      this.pastReservationsList,
      this.pastHasMore = false});
  final SelectedRentType selectedRentType;
  final bool upComingHasMore;
  final bool pastHasMore;
  final List<Reservation>? upComingReservationsList;
  final List<Reservation>? pastReservationsList;
  final bool isAuthorized;
  final RequestStatus upComingRequestStatus;
  final RequestStatus pastRequestStatus;
  final bool showUnAuthorizedWidget;
  @override
  List<Object?> get props => [
        selectedRentType,
        upComingHasMore,
        isAuthorized,
        upComingRequestStatus,
        showUnAuthorizedWidget,
        upComingReservationsList,
        pastRequestStatus,
        pastReservationsList,
        pastHasMore
      ];

  MyRentsState copyWith(
      {SelectedRentType? selectedRentType,
      RequestStatus? upComingRequestStatus,
      RequestStatus? pastRequestStatus,
      bool? upComingHasMore,
      List<Reservation>? upComingReservationsList,
      List<Reservation>? pastReservationsList,
      bool? isAuthorized,
      bool? showUnAuthorizedWidget,
      bool? pastHasMore}) {
    return MyRentsState(
        selectedRentType: selectedRentType ?? this.selectedRentType,
        upComingHasMore: upComingHasMore ?? this.upComingHasMore,
        upComingReservationsList: upComingReservationsList ?? this.upComingReservationsList,
        isAuthorized: isAuthorized ?? this.isAuthorized,
        pastHasMore: pastHasMore ?? this.pastHasMore,
        upComingRequestStatus: upComingRequestStatus ?? this.upComingRequestStatus,
        showUnAuthorizedWidget: showUnAuthorizedWidget ?? this.showUnAuthorizedWidget,
        pastRequestStatus: pastRequestStatus ?? this.pastRequestStatus,
        pastReservationsList: pastReservationsList ?? this.pastReservationsList);
  }
}

enum SelectedRentType { past, upComing }
