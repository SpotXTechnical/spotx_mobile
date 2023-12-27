import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/reservation/i_reservation_repository.dart';
import 'package:spotx/data/remote/reservation/model/get_reservations_response_entity.dart';
import 'package:spotx/data/remote/reservation/model/reservation_summary_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/screens/bloc/summary_event.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/screens/bloc/summary_state.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/utils.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/widgets/alerts/alerts.dart';

class SummaryBloc extends BaseBloc<SummaryEvent, SummaryState> {
  SummaryBloc(this.reservationRepository) : super(const SummaryState()) {
    on<PostReservation>(_postReservation);
    on<ReservationSummary>(_getSummaryReservation);
  }

  final IReservationRepository reservationRepository;
  final TextEditingController messageController = TextEditingController();
  final FocusNode messageFocus = FocusNode();

  static final formKey = GlobalKey<FormState>();

  FutureOr<void> _postReservation(PostReservation event, Emitter<SummaryState> emit) async {
    emit(state.copyWith(isLoading: true));
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
  FutureOr<void> _getSummaryReservation(ReservationSummary event, Emitter<SummaryState> emit) async {
    emit(state.copyWith(summaryLoading: true));
    ApiResponse apiResponse =
    await reservationRepository.getSummaryReservation(event.from, event.to, event.unitId, event.unitType);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          ReservationSummaryEntity reservationSummary = apiResponse.data.data;
          emit(
            state.copyWith(
              summaryLoading: false,
              reservationSummary: reservationSummary,
            ),
          );
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(summaryLoading: false));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened in summary");
            Navigator.pop(navigationKey.currentContext!);
          }
        });
  }

}