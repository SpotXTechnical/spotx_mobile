import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/local/shared_prefs_manager.dart';
import 'package:spotx/data/remote/reservation/i_reservation_repository.dart';
import 'package:spotx/data/remote/reservation/model/get_reservations_response_entity.dart';
import 'package:spotx/login_observing/login_observer.dart';
import 'package:spotx/presentation/main/screens/myrents/bloc/my_rents_event.dart';
import 'package:spotx/presentation/main/screens/myrents/bloc/my_rents_state.dart';
import 'package:spotx/utils/network/api_response.dart';

import 'package:spotx/login_observing/login_single_tone.dart';

class MyRentsBloc extends BaseBloc<MyRentsEvent, MyRentsState> implements LoginObserver{
  MyRentsBloc(this.reservationRepository) : super(const MyRentsState()) {
    LoginSingleTone().subscribe(this);
    on<MyRentCheckIfUserIsLoggedInEvent>(_checkIfLoggedIn);
    on<GetReservations>(_getReservations);
    on<GetUpcomingReservations>(_getUpcomingReservations);
    on<GetPastReservations>(_getPastReservations);
    on<LoadMoreUpComingReservations>(_loadMoreUpComingReservationsList);
    on<LoadMorePastReservations>(_loadMorePastReservationsList);
    on<SetSelectedRentType>(_setSelectedRentType);
  }

  int upComingPage = 1;
  int pastPage = 1;
  final IReservationRepository reservationRepository;

  static const tag = "MyRentsBloc";

  @override
  String? observerName = tag;

  @override
  void update() {
    add(MyRentCheckIfUserIsLoggedInEvent());
  }

  _getReservations(GetReservations event, Emitter<MyRentsState> emit) async {
    await initiateUpComingReservationList(emit, 1, 0);
    await initiatePastReservationList(emit, 0, 1);
  }

  _setSelectedRentType(SetSelectedRentType event, Emitter<MyRentsState> emit) async {
    emit(state.copyWith(selectedRentType: event.selectedRentType));
  }

  _getUpcomingReservations(GetUpcomingReservations event, Emitter<MyRentsState> emit) async {
    await initiateUpComingReservationList(emit, 1, 0);

  }

  _getPastReservations(GetPastReservations event, Emitter<MyRentsState> emit) async {
    await initiatePastReservationList(emit, 0, 1);
  }

  FutureOr<void> initiateUpComingReservationList(Emitter<MyRentsState> emit, int upcoming, int past) async {
    upComingPage = 1;
    emit(state.copyWith(upComingRequestStatus: RequestStatus.loading, upComingHasMore: false));
    ApiResponse apiResponse = await reservationRepository.getReservations(upcoming, past, upComingPage);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Reservation> reservations = apiResponse.data.data;
            bool hasMore = apiResponse.data.meta!.total! > reservations.length;
            emit(state.copyWith(
              upComingHasMore: hasMore,
              upComingReservationsList: reservations,
              upComingRequestStatus: RequestStatus.success,
              isAuthorized: true,
            ));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(upComingRequestStatus: RequestStatus.failure));
          }
        });
  }

  FutureOr<void> initiatePastReservationList(Emitter<MyRentsState> emit, int upcoming, int past) async {
    pastPage = 1;
    emit(state.copyWith(pastRequestStatus: RequestStatus.loading, pastHasMore: false));
    ApiResponse apiResponse = await reservationRepository.getReservations(upcoming, past, pastPage);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Reservation> reservations = apiResponse.data.data;
            bool hasMore = apiResponse.data.meta!.total! > reservations.length;
            emit(state.copyWith(
                pastHasMore: hasMore, pastReservationsList: reservations, pastRequestStatus: RequestStatus.success, isAuthorized: true));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(pastRequestStatus: RequestStatus.failure));
          }
        });
  }

  FutureOr<void> _loadMoreUpComingReservationsList(LoadMoreUpComingReservations event, Emitter<MyRentsState> emit) async {
    upComingPage++;
    ApiResponse apiResponse = await reservationRepository.getReservations(1, 0, upComingPage);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Reservation> reservations = apiResponse.data.data;
            List<Reservation> allReservations = [...?state.upComingReservationsList, ...reservations];
            var meta = apiResponse.data.meta!;
            bool hasMore = meta.currentPage! < meta.lastPage!;
            emit(state.copyWith(upComingHasMore: hasMore, upComingReservationsList: allReservations));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _loadMorePastReservationsList(LoadMorePastReservations event, Emitter<MyRentsState> emit) async {
    pastPage++;
    ApiResponse apiResponse = await reservationRepository.getReservations(0, 1, pastPage);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Reservation> reservations = apiResponse.data.data;
            List<Reservation> allReservations = [...?state.pastReservationsList, ...reservations];
            var meta = apiResponse.data.meta!;
            bool hasMore = meta.currentPage! < meta.lastPage!;
            emit(state.copyWith(pastHasMore: hasMore, pastReservationsList: allReservations));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _checkIfLoggedIn(MyRentCheckIfUserIsLoggedInEvent event, Emitter<MyRentsState> emit) async {
    emit(state.copyWith(showUnAuthorizedWidget: false));
    if (await isLoggedInBefore()) {
      add(GetReservations());
    } else {
      emit(state.copyWith(showUnAuthorizedWidget: true));
    }
  }


  @override
  Future<void> close() {
    debugPrint("$runtimeType close() }");
    LoginSingleTone().unSubscribe(this);
    return super.close();
  }

}