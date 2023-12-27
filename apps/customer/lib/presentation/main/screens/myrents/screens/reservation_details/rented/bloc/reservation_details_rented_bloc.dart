import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/reservation/i_reservation_repository.dart';
import 'package:spotx/data/remote/reservation/model/get_reservations_response_entity.dart';
import 'package:spotx/data/remote/unit/model/image_entity.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/rented/bloc/reservation_details_rented_event.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/rented/bloc/reservations_details_rented_state.dart';
import 'package:spotx/utils/media_picker_manager.dart';
import 'package:spotx/utils/network/api_response.dart';

class ReservationDetailsRentedBloc extends BaseBloc<ReservationDetailsRentedEvent, ReservationDetailsRentedState> {
  ReservationDetailsRentedBloc(this.reservationRepository) : super(const InitialReservationDetailsRentedState()) {
    on<GetReservation>(_getReservation);
  }

  final IReservationRepository reservationRepository;

  FutureOr<void> _getReservation(GetReservation event, Emitter<ReservationDetailsRentedState> emit) async {
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
            emit(const InitialReservationDetailsRentedState());
          }
        });
  }
}
