import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/reservation/i_reservation_repository.dart';
import 'package:spotx/data/remote/reservation/model/get_reservations_response_entity.dart';
import 'package:spotx/data/remote/unit/model/image_entity.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/pending/bloc/reservation_details_pending_event.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/pending/bloc/reservations_details_pending_state.dart';
import 'package:spotx/utils/media_picker_manager.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/style/theme.dart';

import '../../../../../../../../data/local/shared_prefs_manager.dart';
import '../../../../../../../../generated/locale_keys.g.dart';

class ReservationDetailsPendingBloc extends BaseBloc<ReservationDetailsPendingEvent, ReservationDetailsPendingState> {
  ReservationDetailsPendingBloc(this.reservationRepository) : super(const ReservationDetailsPendingState()) {
    on<GetReservation>(_getReservation);
    on<CancelReservation>(_cancelReservation);
    on<ReservationCheckIfUserIsLoggedInEvent>(_checkIfLoggedIn);
  }

  final IReservationRepository reservationRepository;

  FutureOr<void> _getReservation(GetReservation event, Emitter<ReservationDetailsPendingState> emit) async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));

    ApiResponse apiResponse = await reservationRepository.getReservationById(event.reservationId);
    await handleResponse(
        result: apiResponse,
        onSuccess: () async {
          Reservation reservation = apiResponse.data.data;
          if (reservation.unit?.images != null) {
            for (var element in reservation.unit!.images!) {
              if (element.type == videoType) {
                element.thumbnail = await getVideoThumbnailFromNetwork(element.url);
              }
            }
          }
          emit(state.copyWith(reservation: reservation, requestStatus: RequestStatus.success));
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(requestStatus: RequestStatus.failure));
          }
        });
  }

  FutureOr<void> _cancelReservation(CancelReservation event, Emitter<ReservationDetailsPendingState> emit) async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));
    ApiResponse apiResponse = await reservationRepository.cancelReservation(event.reservationId);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          Fluttertoast.showToast(
              msg: LocaleKeys.cancelReservationSuccessMessage.tr(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: pacificBlue,
              textColor: kWhite);
          navigationKey.currentState?.pop();
        },
        onFailed: () {
          if (apiResponse.error != null) {
            Fluttertoast.showToast(
                msg: LocaleKeys.error.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: kWhite);
            emit(state.copyWith(requestStatus: RequestStatus.success));
          }
        });
  }

  FutureOr<void> _checkIfLoggedIn(
      ReservationCheckIfUserIsLoggedInEvent event, Emitter<ReservationDetailsPendingState> emit) async {
    emit(state.copyWith(showUnAuthorizedWidget: false));
    if (await isLoggedInBefore()) {
      if (event.reservationId != null) {
        add(GetReservation(event.reservationId!));
      } else {
        emit(state.copyWith(isReservationDataValid: false));
      }
    } else {
      emit(state.copyWith(showUnAuthorizedWidget: true));
    }
  }
}