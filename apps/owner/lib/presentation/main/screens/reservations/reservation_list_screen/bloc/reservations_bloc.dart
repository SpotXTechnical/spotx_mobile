import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/filter_queryies.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/reservation/i_reservation_repository.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/bloc/reservations_event.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/bloc/reservations_state.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/model/reservations_calender_config.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/style/theme.dart';

class ReservationsBloc extends BaseBloc<ReservationsEvent, ReservationsState> {
  ReservationsBloc(this.reservationRepository, this.unitRepository) : super(const ReservationsState()) {
    on<GetReservationsByPastOrUpcomingEvent>(_getReservationsByCurrentOrPast);
    on<GetReservationsByMonth>(_getReservationsByMonth);
    on<LoadMoreReservations>(_loadMoreReservations);
    on<ApproveReservationEvent>(_approveReservation);
    on<RejectReservationEvent>(_rejectReservation);
    on<ChangeShowType>(_changeShowType);
    on<GetUnits>(_getUnits);
    scrollController.addListener(() {
      debugPrint('scrollController scrollController.position.maxScrollExtent : ${scrollController.position.maxScrollExtent} , scrollController.offset: ${scrollController.offset}');
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        debugPrint('load more addListener called');
        switch (state.selectedReservationsType) {
          case SelectedReservationsType.past:
            add(LoadMoreReservations(0, 1, state.selectedReservationsType));
            break;
          case SelectedReservationsType.upComing:
            add(LoadMoreReservations(1, 0, state.selectedReservationsType));
            break;
        }
      }
    });
  }

  final IReservationRepository reservationRepository;
  final IUnitRepository unitRepository;
  ScrollController scrollController = ScrollController();

  int page = 1;

  FutureOr<void> _getReservationsByCurrentOrPast(GetReservationsByPastOrUpcomingEvent event, Emitter<ReservationsState> emit) async {
    emit(ReservationsState(
        typesReservationsRequestStatus: RequestStatus.loading,
        selectedReservationsType: event.selectedReservationsType,
        hasMore: false,
        reservationShowType: state.reservationShowType,
        monthReservations: state.monthReservations,
        monthReservationsRequestStatus: state.monthReservationsRequestStatus,
        units: state.units,
        focusedDay: state.focusedDay,
        reservationsCalenderConfig: state.reservationsCalenderConfig));
    emit(state.copyWith(
        typesReservationsRequestStatus: RequestStatus.loading, selectedReservationsType: event.selectedReservationsType, hasMore: false));
    await initReservationsList(emit, event);
  }

  FutureOr<void> _getReservationsByMonth(GetReservationsByMonth event, Emitter<ReservationsState> emit) async {
    emit(state.copyWith(monthReservationsRequestStatus: RequestStatus.loading, focusedDay: event.date, reservationsCalenderConfig: event.config));
    ApiResponse apiResponse =
        await reservationRepository.getReservations(page: page, unitId: event.config.id, month: event.date.month, type: event.config.type);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Reservation> reservations = apiResponse.data.data;
            for (var reservation in reservations) {
              reservation.to = reservation.to?.subtract(const Duration(days: 1));
            }
            emit(state.copyWith(monthReservations: reservations, monthReservationsRequestStatus: RequestStatus.success));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(monthReservationsRequestStatus: RequestStatus.failure));
          }
        });
  }

  FutureOr<void> _getUnits(GetUnits event, Emitter<ReservationsState> emit) async {
    emit(state.copyWith(monthReservationsRequestStatus: RequestStatus.loading, focusedDay: DateTime.now()));
    ApiResponse apiResponse = await unitRepository.getUnits(FilterQueries(escapePagination: 1, withModels: 1));
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Unit> units = apiResponse.data.data;
            if (units.isNotEmpty) {
              Unit unit = units[0];
              ReservationsCalenderConfig config = ReservationsCalenderConfig(unit.id.toString(), unit.type!, unit.title!, unit.defaultPrice!);
              add(GetReservationsByMonth(config, DateTime.now()));
              emit(state.copyWith(units: units, monthReservationsRequestStatus: RequestStatus.success, reservationsCalenderConfig: config));
            }
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
            emit(state.copyWith(monthReservationsRequestStatus: RequestStatus.failure));
          }
        });
  }

  FutureOr<void> _changeShowType(ChangeShowType event, Emitter<ReservationsState> emit) async {
    if (state.reservationShowType == ReservationShowType.list) {
      emit(state.copyWith(reservationShowType: ReservationShowType.calender));
    } else {
      emit(state.copyWith(reservationShowType: ReservationShowType.list));
    }
  }

  FutureOr<void> initReservationsList(Emitter<ReservationsState> emit, GetReservationsByPastOrUpcomingEvent event) async {
    page = 1;
    emit(state.copyWith(typesReservationsRequestStatus: RequestStatus.loading));
    ApiResponse apiResponse = await reservationRepository.getReservations(page: page, upcoming: event.upcoming, past: event.past);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Reservation> reservations = apiResponse.data.data;
            bool hasMore = apiResponse.data.meta!.total! > reservations.length;
            emit(state.copyWith(hasMore: hasMore, typesReservations: reservations, typesReservationsRequestStatus: RequestStatus.success));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(typesReservationsRequestStatus: RequestStatus.failure));
          }
        });
  }

  FutureOr<void> _loadMoreReservations(LoadMoreReservations event, Emitter<ReservationsState> emit) async {
    page++;
    ApiResponse apiResponse = await reservationRepository.getReservations(page: page, upcoming: event.upcoming, past: event.past);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Reservation> reservations = apiResponse.data.data;
            List<Reservation> allReservations = [...?state.typesReservations, ...reservations];
            var meta = apiResponse.data.meta!;
            bool hasMore = meta.currentPage! < meta.lastPage!;
            emit(state.copyWith(hasMore: hasMore, typesReservations: allReservations));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _approveReservation(ApproveReservationEvent event, Emitter<ReservationsState> emit) async {
    List<Reservation> newList = Reservation.createNewReservationsList(state.typesReservations);
    newList.firstWhere((element) => element.id.toString() == event.reservationId).isAcceptEnabled = false;
    emit(state.copyWith(typesReservations: newList));
    ApiResponse apiResponse = await reservationRepository.approveReservation(event.reservationId);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            Fluttertoast.showToast(
                msg: LocaleKeys.reservationAcceptanceMessage.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: pacificBlue,
                textColor: kWhite);
            state.copyWith(typesReservationsRequestStatus: RequestStatus.loading);
            if (state.selectedReservationsType == SelectedReservationsType.upComing) {
              add(GetReservationsByPastOrUpcomingEvent(1, 0, state.selectedReservationsType));
            } else {
              add(GetReservationsByPastOrUpcomingEvent(0, 1, state.selectedReservationsType));
            }
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _rejectReservation(RejectReservationEvent event, Emitter<ReservationsState> emit) async {
    List<Reservation> newList = Reservation.createNewReservationsList(state.typesReservations);
    newList.firstWhere((element) => element.id.toString() == event.reservationId).isRejectEnabled = false;
    emit(state.copyWith(typesReservations: newList));
    ApiResponse apiResponse = await reservationRepository.rejectReservation(event.reservationId);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            Fluttertoast.showToast(
                msg: LocaleKeys.reservationRejectionMessage.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: pacificBlue,
                textColor: kWhite);
            state.copyWith(typesReservationsRequestStatus: RequestStatus.loading);
            if (state.selectedReservationsType == SelectedReservationsType.upComing) {
              add(GetReservationsByPastOrUpcomingEvent(1, 0, state.selectedReservationsType));
            } else {
              add(GetReservationsByPastOrUpcomingEvent(0, 1, state.selectedReservationsType));
            }
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }
}