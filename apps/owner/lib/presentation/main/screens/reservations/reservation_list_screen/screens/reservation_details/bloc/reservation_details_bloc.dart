import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/model/MediaFile.dart';
import 'package:owner/data/remote/reservation/i_reservation_repository.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_two/widgets/utils.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/reservation_details/bloc/reservation_details_event.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/reservation_details/bloc/reservations_details_state.dart';

import '../../../../../../../../data/remote/reservation/model/reservation_entity.dart';
import '../../../../../../../../generated/locale_keys.g.dart';
import '../../../../../../../../utils/network/api_response.dart';
import '../../../../../../../../utils/style/theme.dart';

class ReservationDetailsBloc extends BaseBloc<ReservationDetailsEvent, ReservationDetailsState> {
  ReservationDetailsBloc(this.reservationRepository) : super(const ReservationDetailsState()) {
    on<GetReservation>(_getReservation);
    on<ApproveReservationEvent>(_approveReservation);
    on<RejectReservationEvent>(_rejectReservation);
  }

  final IReservationRepository reservationRepository;

  FutureOr<void> _getReservation(GetReservation event, Emitter<ReservationDetailsState> emit) async {
    emit(state.copyWith(isLoading: true));
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
          emit(state.copyWith(reservation: reservation, isLoading: false));
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isLoading: false));
          }
        });
  }

  FutureOr<void> _approveReservation(ApproveReservationEvent event, Emitter<ReservationDetailsState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await reservationRepository.approveReservation(state.reservation!.id.toString());
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            Fluttertoast.showToast(
                msg: LocaleKeys.reservationAcceptanceMessage.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: pacificBlue,
                textColor: kWhite);
            emit(state.copyWith(isLoading: false));
            add(GetReservation(state.reservation!.id.toString()));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
            emit(state.copyWith(isLoading: false));
          }
        });
  }

  FutureOr<void> _rejectReservation(RejectReservationEvent event, Emitter<ReservationDetailsState> emit) async {
    ApiResponse apiResponse = await reservationRepository.rejectReservation(state.reservation!.id.toString());
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            Fluttertoast.showToast(
                msg: LocaleKeys.reservationRejectionMessage.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: pacificBlue,
                textColor: kWhite);
            add(GetReservation(state.reservation!.id.toString()));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }
}