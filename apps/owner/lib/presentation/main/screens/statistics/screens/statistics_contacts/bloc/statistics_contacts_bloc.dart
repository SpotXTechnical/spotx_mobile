import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/data/remote/statistics/i_statistics_repository.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_contacts/bloc/statistics_contacts_event.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_contacts/utils.dart';
import 'package:owner/utils/network/api_response.dart';
import 'statistics_contacts_state.dart';

class StatisticsContactsBloc extends BaseBloc<StatisticsContactsEvent, StatisticsContactsState> {
  StatisticsContactsBloc(this.statisticsRepository) : super(const StatisticsContactsState()) {
    on<SetSelectionUserTypeEvent>(_setSelectedFinancialType);
    on<GetUsersEvent>(_getUsers);
    on<LoadMoreUsersEvent>(_loadMoreUsers);
    on<GetGuestsEvent>(_getGuests);
    on<LoadMoreGuestsEvent>(_loadMoreGuests);
  }
  final IStatisticsRepository statisticsRepository;
  int page = 1;

  FutureOr<void> _setSelectedFinancialType(
      SetSelectionUserTypeEvent event, Emitter<StatisticsContactsState> emit) async {
    emit(state.copyWith(selectedUserType: event.selectedUsersType));
    if (event.selectedUsersType == SelectedUsersType.user) {
      add(const GetUsersEvent());
    } else {
      add(const GetGuestsEvent());
    }
  }

  _getUsers(GetUsersEvent event, Emitter<StatisticsContactsState> emit) async {
    await initiateUsersList(emit);
  }

  FutureOr<void> initiateUsersList(Emitter<StatisticsContactsState> emit) async {
    page = 1;
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await statisticsRepository.getUsers(page);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<User> users = apiResponse.data.data;
            bool hasMore = apiResponse.data.meta!.total! > users.length;
            emit(state.copyWith(hasMore: hasMore, entities: users, isLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _loadMoreUsers(LoadMoreUsersEvent event, Emitter<StatisticsContactsState> emit) async {
    page++;
    ApiResponse apiResponse = await statisticsRepository.getUsers(page);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<User> users = apiResponse.data.data;
            List<User> allUsers = [...state.entities as List<User>, ...users];
            var meta = apiResponse.data.meta!;
            bool hasMore = meta.currentPage! < meta.lastPage!;
            emit(state.copyWith(hasMore: hasMore, entities: allUsers));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  _getGuests(GetGuestsEvent event, Emitter<StatisticsContactsState> emit) async {
    await initiateGuestsList(emit);
  }

  FutureOr<void> initiateGuestsList(Emitter<StatisticsContactsState> emit) async {
    page = 1;
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await statisticsRepository.getGuests(page);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<User> guests = apiResponse.data.data;
            bool hasMore = apiResponse.data.meta!.total! > guests.length;
            emit(state.copyWith(hasMore: hasMore, entities: guests, isLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _loadMoreGuests(LoadMoreGuestsEvent event, Emitter<StatisticsContactsState> emit) async {
    page++;
    ApiResponse apiResponse = await statisticsRepository.getGuests(page);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<User> guests = apiResponse.data.data;
            List<User> allGuests = [...state.entities as List<User>, ...guests];
            var meta = apiResponse.data.meta!;
            bool hasMore = meta.currentPage! < meta.lastPage!;
            emit(state.copyWith(hasMore: hasMore, entities: allGuests));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }
}
