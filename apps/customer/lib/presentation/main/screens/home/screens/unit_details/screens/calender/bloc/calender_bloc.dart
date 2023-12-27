import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/reservation/i_reservation_repository.dart';
import 'package:spotx/data/remote/reservation/model/get_reservations_response_entity.dart';
import 'package:spotx/data/remote/unit/i_unit_repository.dart';
import 'package:spotx/data/remote/unit/model/CalenderUnit.dart';
import 'package:spotx/data/remote/unit/model/room_details_entity.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/utils.dart';
import 'package:collection/collection.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/table_calender/table_calendar.dart';
import 'package:spotx/utils/utils.dart';
import 'package:spotx/utils/widgets/alerts/alerts.dart';

import '../../../../../../../../../generated/locale_keys.g.dart';
import '../../../../../../../../../utils/navigation/navigation_helper.dart';
import 'calender_event.dart';
import 'calender_state.dart';

class CalenderBloc extends BaseBloc<CalenderEvent, CalenderState> {
  CalenderBloc(this.unitRepository, this.reservationRepository) : super(InitialCalenderState(DateTime.now())) {
    on<DayTappedEvent>(_onDayTapped);
    on<RangeSelectedEvent>(_onRangeSelected);
    on<InitDataEvent>(_addFocusedDay);
    on<PostReservation>(_postReservation);
    on<GetRoomDetailsEvent>(_getRoomDetails);
  }
  final IUnitRepository unitRepository;
  final IReservationRepository reservationRepository;

  FutureOr<void> _onDayTapped(DayTappedEvent event, Emitter<CalenderState> emit) {
    emit(state.copyWith(
        focusedDay: event.focusedDay,
        rangeSelectionMode: event.rangeSelectionMode,
        selectedDay: event.selectedDay,
        rangeStartDay: event.rangeStart,
        rangeEndDay: event.rangeEnd));
  }

  FutureOr<void> _onRangeSelected(RangeSelectedEvent event, Emitter<CalenderState> emit) {
    emit(CalenderState(
        roomRequestStatus: state.roomRequestStatus,
        focusedDay: event.focusedDay,
        selectedDay: event.selectedDay,
        rangeStartDay: event.rangeStart,
        rangeEndDay: event.rangeEnd,
        startedDay: event.startedDay,
        startDayWeekName: event.startDayWeekName,
        endedDay: event.endedDay,
        endDayWeekName: event.endDayWeekName,
        calenderUnit: state.calenderUnit,
        roomTitle: state.roomTitle,
        roomId: state.roomId,
        isLoading: false));
  }

  FutureOr<void> _addFocusedDay(InitDataEvent event, Emitter<CalenderState> emit) {
    if (event.calenderUnit == null) {
      emit(state.copyWith(focusedDay: event.focusedDay, isLoading: false, roomTitle: state.roomTitle));
    } else {
      ActiveRange? activeRange = getSelectedOfferPriceRangeIfComingFromOfferScreen(event.calenderUnit!);
      DateTime? rangeEndDay;
      DateTime? rangeStartDay;
      if (activeRange != null) {
        emit(state.copyWith(calenderUnit: event.calenderUnit, isLoading: false));
        rangeStartDay = activeRange.startDay;
        rangeEndDay = activeRange.endDay;
        fireRangeSelectedEvent(rangeStartDay, rangeEndDay, rangeStartDay!);
      } else {
        emit(
          state.copyWith(
              focusedDay: event.focusedDay,
              calenderUnit: event.calenderUnit,
              isLoading: false,
              rangeEndDay: rangeEndDay,
              rangeStartDay: rangeStartDay,
              roomTitle: state.roomTitle),
        );
      }
    }
  }

  FutureOr<void> _postReservation(PostReservation event, Emitter<CalenderState> emit) async {
    emit(state.copyWith(isLoading: true, roomTitle: state.roomTitle));
    ApiResponse apiResponse =
        await reservationRepository.postReservation(event.from, event.to, event.unitId, event.unitType);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          Reservation reservation = apiResponse.data.data;
          showOneButtonAlert(navigationKey.currentContext!,
              title: LocaleKeys.goodJob.tr(),
              buttonTitle: LocaleKeys.navigateToReservationScreen.tr(),
              body: LocaleKeys.theReservationCompleted.tr(),
              isDismissible: false, onPressed: () {
            navigateToReservationDetailsScreen(reservation.id!);
          });
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
            emit(state.copyWith(isLoading: false));
          }
        });
  }

  FutureOr<void> _getRoomDetails(GetRoomDetailsEvent event, Emitter<CalenderState> emit) async {
    if (event.type == UnitType.camp.name) {
      emit(state.copyWith(
          roomRequestStatus: RequestStatus.loading, roomTitle: event.title, roomId: event.roomId.toString()));
      ApiResponse apiResponse = await unitRepository.getRoomDetails(event.roomId);
      await handleResponse(
          result: apiResponse,
          onSuccess: () {
            RoomDetailsData room = apiResponse.data.data;
            emit(CalenderState(
                roomRequestStatus: RequestStatus.success,
                isLoading: false,
                calenderUnit: CalenderUnit(room.id!, room.defaultPrice!, event.type, room.activeRanges!,
                    room.activeReservations!, null, room.title ?? "backend empty data"),
                focusedDay: DateTime.now(),
                isReservationCompleted: false,
                rangeStartDay: null,
                rangeEndDay: null,
                roomTitle: state.roomTitle,
                roomId: state.roomId,
                selectedDay: null));
          },
          onFailed: () {
            if (apiResponse.error != null) {
              showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
            }
          });
    }
  }

  void fireRangeSelectedEvent(DateTime? start, DateTime? end, DateTime focusedDay) {
    String? startedDay;
    String? startDayWeekName;
    String? endedDay;
    String? endDayWeekName;
    if (start != null) {
      String month = months[start.month - 1];
      String day = start.day.toString();
      startedDay = "$day $month";
      startDayWeekName = DateFormat('EEE').format(start);
    } else {
      startedDay = "-  -  -";
      startDayWeekName = "-  -  -";
    }
    if (end != null) {
      String month = months[end.month - 1];
      String day = end.day.toString();
      endedDay = "$day $month";
      endDayWeekName = DateFormat('EEE').format(end);
    } else {
      endedDay = "-  -  -";
      endDayWeekName = "-  -  -";
    }
    add(RangeSelectedEvent(focusedDay, RangeSelectionMode.toggledOn, null, start, end, startedDay, endedDay,
        startDayWeekName, endDayWeekName));
  }
}

ActiveRange? getSelectedOfferPriceRangeIfComingFromOfferScreen(CalenderUnit calenderUnit) {
  return calenderUnit.activeRanges?.firstWhereOrNull((element) => element.isComingFromOfferScreen);
}