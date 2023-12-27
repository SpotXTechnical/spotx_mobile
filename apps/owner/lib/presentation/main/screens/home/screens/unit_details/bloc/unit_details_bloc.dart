import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/local/shared_prefs_manager.dart';
import 'package:owner/data/remote/add_unit/i_unit_repository.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/auth/models/guest.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/data/remote/reservation/i_reservation_repository.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_two/widgets/utils.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/bloc/unit_details_event.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/bloc/unit_details_state.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/observation_managers/home_observable_single_tone.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:collection/collection.dart';
import 'package:owner/utils/table_calender/utils.dart';

class UnitDetailsBloc extends BaseBloc<UnitDetailsEvent, UnitDetailsState> {
  UnitDetailsBloc(this.unitRepository, this.reservationRepository) : super(const UnitDetailsState()) {
    on<GetUnitDetails>(_getUnitDetails);
    on<SetSelectedContentTypeEvent>(_setSelectedContentType);
    on<SetSelectedRoom>(_setSelectedRoom);
    on<UnitDetailsSetUnit>(_setUnit);
    on<ApproveReservationEvent>(_approveReservation);
    on<RejectReservationEvent>(_rejectReservation);
    on<CancelReservationEvent>(_cancelReservation);
    on<PostReservationEvent>(_postReservation);
  }
  final IUnitRepository unitRepository;
  final IReservationRepository reservationRepository;

  FutureOr<void> _getUnitDetails(GetUnitDetails event, Emitter<UnitDetailsState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await unitRepository.getUnitById(event.id.toString());
    await handleResponse(
        result: apiResponse,
        onSuccess: () async {
          Unit unitData = apiResponse.data.data;
          if (unitData.images != null) {
            for (var element in unitData.images!) {
              if (element.type == videoType) {
                element.thumbnail = await getVideoThumbnailFromNetwork(element.url);
              }
            }
          }
          final reservations = _getReservations(unitData, state.selectedRoom)
              .where((element) => element.status != ReservationStatus.reject.name)
              .toList();
          emit(state.copyWith(
            isLoading: false,
            unit: unitData,
            reservedRanges: reservations,
            selectedRoom: unitData.rooms != null && unitData.rooms!.isNotEmpty
                ? unitData.rooms![0]
                : null,
          ));
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isError: true, isLoading: false));
          }
        });
  }

  FutureOr<void> _setSelectedContentType(SetSelectedContentTypeEvent event, Emitter<UnitDetailsState> emit) async {
    emit(state.copyWith(selectedContentType: event.selectedContentType));
  }

  FutureOr<void> _setUnit(UnitDetailsSetUnit event, Emitter<UnitDetailsState> emit) async {
    emit(state.copyWith(unit: event.unit));
    HomeObservableSingleTone().notify(UpdateSelectedRegionsUnit());
  }

  FutureOr<void> _setSelectedRoom(SetSelectedRoom event, Emitter<UnitDetailsState> emit) async {
    emit(state.copyWith(selectedRoom: event.selectedRoom));
  }

  FutureOr<void> _approveReservation(ApproveReservationEvent event, Emitter<UnitDetailsState> emit) async {
    final apiResponse = await reservationRepository
        .approveReservation(event.reservation.id.toString());
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            _showToast( LocaleKeys.reservationAcceptanceMessage.tr());
            final approvedReservation = _getReservationFromReservedRangesById(event.reservation.id);
            approvedReservation?.status = ReservationStatus.approved.name;

            emit(state.copyWith(currentDay: approvedReservation?.from));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
          emit(state.copyWith(isApprovedReservationLoading: false));
        });
  }

  FutureOr<void> _rejectReservation(RejectReservationEvent event, Emitter<UnitDetailsState> emit) async {
    ApiResponse apiResponse = await reservationRepository.rejectReservation(event.reservation.id.toString());
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            _showToast( LocaleKeys.reservationRejectionMessage.tr());
            _removeReservationById(event.reservation.id);
            emit(state.copyWith(currentDay: event.reservation.from));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _cancelReservation(CancelReservationEvent event, Emitter<UnitDetailsState> emit) async {
    ApiResponse apiResponse = await reservationRepository
        .cancelReservation(event.reservation.id.toString());
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          final message = apiResponse.data["message"];
          if (message != null) {
            if (event.isReservedByQuest) {
              _removeReservationById(event.reservation.id);
            } else {
              final res = _getReservationFromReservedRangesById(event.reservation.id);
              res?.hasCancelRequest = true;
              _showToast(message);
            }
            DateTime currentDay = calculateCurrentDayToDisplay(event.reservation.from ?? DateTime(2023));
            emit(state.copyWith(currentDay: currentDay));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ??
                "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _postReservation(
    PostReservationEvent event,
    Emitter<UnitDetailsState> emit,
  ) async {
    final credentials = Injector().get<SharedPrefsManager>().credentials;
    final res = Reservation(
      from: event.day,
      to: event.day,
      guest: Guest(
        name: credentials?.user?.name ?? " ",
        phone: credentials?.user?.phone ?? " ",
      ),
      status: ReservationStatus.approved.name,
    );
    state.reservedRanges?.add(res);
    DateTime currentDay = calculateCurrentDayToDisplay(event.day);
    emit(state.copyWith(currentDay: currentDay));
    ApiResponse apiResponse = await reservationRepository.postReservation(
      DateFormat.yMd("en").format(event.day),
      DateFormat.yMd("en").format(event.day.add(const Duration(days: 1))),
      "",
      state.unit?.id ?? "",
      state.unit?.type ?? "",
      User(
        name: credentials?.user?.name ?? " ",
        phone: credentials?.user?.phone ?? " ",
      ),
    );
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            Reservation reservation = apiResponse.data.data;
            reservation.to = reservation.to?.subtract(const Duration(days: 1));
            state.reservedRanges?.remove(res);
            state.reservedRanges?.add(reservation);
            DateTime currentDay = calculateCurrentDayToDisplay(event.day);
            emit(state.copyWith(currentDay: currentDay));
          }
        },
        onFailed: () {
          // remove the reservation from the list
          state.reservedRanges?.remove(res);
          emit(state.copyWith(currentDay: calculateCurrentDayToDisplay(event.day)));
          if (apiResponse.error != null) {
            if (apiResponse.error?.extra != null) {
              _showToast(
                LocaleKeys.addNewReservationErrorMessage.tr(),
                Colors.red,
              );
            } else {
              showErrorMsg(apiResponse.error?.errorMsgKey ??
                  "Some thing Error has been happened");
            }
          }
        });
  }

  DateTime calculateCurrentDayToDisplay(DateTime eventDay) {
    DateTime currentDay;
    final isUpdateSameDay = state.currentDay == eventDay;

    if (isUpdateSameDay) {
      currentDay = eventDay.add(const Duration(days: 1));
      if (currentDay.month != state.currentDay?.month) {
        currentDay = eventDay.subtract(const Duration(days: 1));
      }
    } else {
      currentDay = eventDay;
    }
    if (currentDay.isBefore(kToday)) {
      currentDay = kToday;
    }
    if (currentDay == state.currentDay) {
      currentDay = eventDay.add(const Duration(days: 1));
      if (currentDay.month != state.currentDay?.month) {
        currentDay = eventDay.subtract(const Duration(days: 1));
      }
    }
    return currentDay;
  }

  List<Reservation> _getReservations(Unit unit, Room? selectedRoom) {
    if (selectedRoom != null) {
      final reservations = selectedRoom.reservations??[];
      final originalReservation =  Reservation.createNewReservationsList(reservations);
      for (var reservation in originalReservation) {
        reservation.to = reservation.to?.subtract(const Duration(days: 1));
      }
      return originalReservation;
    }
    final unitReservations = Reservation.createNewReservationsList(unit.reservations);

    for (var reservation in unitReservations) {
      reservation.to = reservation.to?.subtract(const Duration(days: 1));
    }
    return unitReservations;
  }

  Reservation? _getReservationFromReservedRangesById(int? id) =>
      state.reservedRanges?.firstWhereOrNull((reservation) => reservation.id == id);

  void _removeReservationById(int? id) =>
      state.reservedRanges?.removeWhere((reservation) => reservation.id == id);

  void _showToast(
    String message, [
    Color backgroundColor = pacificBlue,
  ]) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: kWhite,
    );
  }
}