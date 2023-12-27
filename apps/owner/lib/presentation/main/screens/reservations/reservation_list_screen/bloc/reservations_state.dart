import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/model/reservations_calender_config.dart';

class ReservationsState extends Equatable {
  const ReservationsState(
      {this.typesReservations,
      this.monthReservations,
      this.hasMore = false,
      this.typesReservationsRequestStatus = RequestStatus.loading,
      this.monthReservationsRequestStatus = RequestStatus.loading,
      this.selectedReservationsType = SelectedReservationsType.upComing,
      this.reservationShowType = ReservationShowType.list,
      this.units,
      this.focusedDay,
      this.reservationsCalenderConfig});

  final List<Reservation>? typesReservations;
  final List<Reservation>? monthReservations;
  final List<Unit>? units;
  final RequestStatus typesReservationsRequestStatus;
  final RequestStatus monthReservationsRequestStatus;
  final bool hasMore;
  final SelectedReservationsType selectedReservationsType;
  final ReservationShowType reservationShowType;
  final DateTime? focusedDay;
  final ReservationsCalenderConfig? reservationsCalenderConfig;

  @override
  List<Object?> get props => [
        typesReservations,
        hasMore,
        selectedReservationsType,
        reservationShowType,
        monthReservations,
        units,
        focusedDay,
        reservationsCalenderConfig,
        typesReservationsRequestStatus,
        monthReservationsRequestStatus
      ];

  ReservationsState copyWith(
      {List<Reservation>? typesReservations,
      List<Reservation>? monthReservations,
      RequestStatus? typesReservationsRequestStatus,
      RequestStatus? monthReservationsRequestStatus,
      bool? hasMore,
      SelectedReservationsType? selectedReservationsType,
      ReservationShowType? reservationShowType,
      List<Unit>? units,
      DateTime? focusedDay,
      ReservationsCalenderConfig? reservationsCalenderConfig}) {
    return ReservationsState(
        monthReservations: monthReservations ?? this.monthReservations,
        typesReservations: typesReservations ?? this.typesReservations,
        typesReservationsRequestStatus: typesReservationsRequestStatus ?? this.typesReservationsRequestStatus,
        hasMore: hasMore ?? this.hasMore,
        selectedReservationsType: selectedReservationsType ?? this.selectedReservationsType,
        reservationShowType: reservationShowType ?? this.reservationShowType,
        monthReservationsRequestStatus: monthReservationsRequestStatus ?? this.monthReservationsRequestStatus,
        units: units ?? this.units,
        focusedDay: focusedDay ?? this.focusedDay,
        reservationsCalenderConfig: reservationsCalenderConfig ?? this.reservationsCalenderConfig);
  }
}

enum SelectedReservationsType { past, upComing }
enum ReservationShowType { list, calender }
enum RequestStatus { failure, success, loading }
