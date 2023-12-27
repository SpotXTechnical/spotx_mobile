import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/bloc/reservations_state.dart';

class UnitDetailsState extends Equatable {
  const UnitDetailsState(
      {this.isLoading = false,
      this.unit,
      this.isError = false,
      this.selectedContentType = SelectedContentType.calender,
      this.selectedRoom,
      this.roomsRequestStatus = RequestStatus.loading,
      this.currentDay,
      this.reservedRanges,
  });

  final Unit? unit;
  final bool isLoading;
  final bool isError;
  final Room? selectedRoom;
  final SelectedContentType selectedContentType;
  final RequestStatus roomsRequestStatus;
  final List<Reservation>? reservedRanges;
  final DateTime? currentDay;
  @override
  List<Object?> get props => [
        unit,
        isLoading,
        isError,
        selectedContentType,
        selectedRoom,
        roomsRequestStatus,
        reservedRanges,
        currentDay
      ];

  UnitDetailsState copyWith({
    Unit? unit,
    bool? isLoading,
    bool? isError,
    DateTime? currentDay,
    SelectedContentType? selectedContentType,
    Room? selectedRoom,
    RequestStatus? roomsRequestStatus,
    bool? isApprovedReservationLoading,
    bool? isRejectReservationLoading,
    List<Reservation>? reservedRanges,
  }) {
    return UnitDetailsState(
      isLoading: isLoading ?? this.isLoading,
      unit: unit ?? this.unit,
      reservedRanges: reservedRanges ?? this.reservedRanges,
      isError: isError ?? this.isError,
      currentDay: currentDay ?? this.currentDay,
      selectedContentType: selectedContentType ?? this.selectedContentType,
      selectedRoom: selectedRoom ?? this.selectedRoom,
      roomsRequestStatus: roomsRequestStatus ?? this.roomsRequestStatus,
    );
  }
}

enum SelectedContentType { overView, review, calender }