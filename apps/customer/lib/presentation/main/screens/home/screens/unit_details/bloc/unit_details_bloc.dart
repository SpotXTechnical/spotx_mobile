import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/reservation/i_reservation_repository.dart';
import 'package:spotx/data/remote/reservation/model/get_reservations_response_entity.dart';
import 'package:spotx/data/remote/unit/i_unit_repository.dart';
import 'package:spotx/data/remote/unit/model/image_entity.dart';
import 'package:spotx/data/remote/unit/model/offer_entity.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/bloc/unit_details_event.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/bloc/unit_details_state.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/model/unit_details_screen_nav_args.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/utils.dart';
import 'package:spotx/utils/media_picker_manager.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/widgets/alerts/alerts.dart';

class UnitDetailsBloc extends BaseBloc<UnitDetailsEvent, UnitDetailsState> {
  UnitDetailsBloc(this.unitRepository, this.reservationRepository) : super(const UnitDetailsState()) {
    on<GetDetails>(_getDetails);
    on<ChangeContentType>(_changeContentType);
    on<UnitDetailsPostReservation>(_postReservation);
  }
  final IUnitRepository unitRepository;
  final IReservationRepository reservationRepository;

  FutureOr<void> _getDetails(GetDetails event, Emitter<UnitDetailsState> emit) async {
    emit(state.copyWith(isLoading: true));
    if (event.unitDetailsScreenNavArgs.type == UnitDetailsScreenType.normalUnit) {
      await getUnit(event, emit);
    } else {
      await getOffer(event, emit);
    }
  }

  Future<void> getOffer(GetDetails event, Emitter<UnitDetailsState> emit) async {
    ApiResponse apiResponse = await unitRepository.getOfferById(event.unitDetailsScreenNavArgs.id);
    await handleResponse(
        result: apiResponse,
        onSuccess: () async {
          OfferEntity offer = apiResponse.data.data;
          offer.addDayToEnd();
          if (offer.unit?.images != null) {
            for (var element in offer.unit!.images!) {
              if (element.type == videoType) {
                element.thumbnail = await getVideoThumbnailFromNetwork(element.url);
              }
            }
          }
          emit(state.copyWith(unit: offer.unit, offerEntity: offer));
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isError: true, isLoading: false));
          }
        });
  }

  Future<void> getUnit(GetDetails event, Emitter<UnitDetailsState> emit) async {
    ApiResponse apiResponse = await unitRepository.getUnitById(event.unitDetailsScreenNavArgs.id);
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
          emit(state.copyWith(unit: unitData));
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isError: true, isLoading: false));
          }
        });
  }

  FutureOr<void> _postReservation(UnitDetailsPostReservation event, Emitter<UnitDetailsState> emit) async {
    emit(state.copyWith(isPostReservationLoading: true));
    ApiResponse apiResponse = await reservationRepository.postReservation(
        state.offerEntity!.startDate?.toIso8601String() ?? "",
        state.offerEntity!.endDate?.toIso8601String() ?? "",
        state.unit!.id!,
        state.unit!.type!
    );
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          emit(state.copyWith(isPostReservationLoading: false));
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
            emit(state.copyWith(isPostReservationLoading: false));
          }
        });
  }

  FutureOr<void> _changeContentType(ChangeContentType event, Emitter<UnitDetailsState> emit) async {
    if (state.selectedContentType == SelectedContentType.review) {
      emit(state.copyWith(selectedContentType: SelectedContentType.overView));
    } else {
      emit(state.copyWith(selectedContentType: SelectedContentType.review));
    }
  }
}