import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/unit/i_unit_repository.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/utils/network/api_response.dart';

import 'favourite_event.dart';
import 'favourite_state.dart';

class FavouriteBloc extends BaseBloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc(this.unitRepository) : super(const InitialFavouriteState()) {
    on<GetFavouriteUnits>(_getFavouriteUnits);
    on<LoadMoreFavouriteUnits>(_loadMoreFavouriteUnits);
    on<RemoveUnFavouriteUnitEvent>(_removeUnFavouriteUnit);
  }

  int page = 1;
  final IUnitRepository unitRepository;

  _getFavouriteUnits(GetFavouriteUnits event, Emitter<FavouriteState> emit) async {
    page = 1;
    await initiateList(emit);
  }

  _removeUnFavouriteUnit(RemoveUnFavouriteUnitEvent event, Emitter<FavouriteState> emit) async {
    List<Unit>? newList = Unit.createNewUnitList(state.unitsList);
    int deletedKey = -1;
    newList.asMap().forEach((key, value) {
      if (value.id == event.unit.id) {
        deletedKey = key;
      }
    });
    if (deletedKey >= 0) {
      newList.removeAt(deletedKey);
    }
    emit(FavouriteUnitsState(hasMore: state.hasMore, units: newList));
  }

  FutureOr<void> initiateList(Emitter<FavouriteState> emit) async {
    emit(const FavouriteLoadingState(isLoading: true, hasMore: false));
    ApiResponse apiResponse = await unitRepository.getFavourite(page);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Unit> favouriteUnits = apiResponse.data.data;
            for (var element in favouriteUnits) {
              element.isFavourite = true;
            }
            bool hasMore = apiResponse.data.meta!.total! > favouriteUnits.length;
            emit(FavouriteUnitsState(hasMore: hasMore, units: favouriteUnits));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _loadMoreFavouriteUnits(LoadMoreFavouriteUnits event, Emitter<FavouriteState> emit) async {
    page++;
    ApiResponse apiResponse = await unitRepository.getFavourite(page);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Unit> favouriteUnits = apiResponse.data.data;
            for (var element in favouriteUnits) {
              element.isFavourite = true;
            }
            List<Unit> allFavouriteUnits = [...?state.unitsList, ...favouriteUnits];
            var meta = apiResponse.data.meta!;
            bool hasMore = meta.currentPage! < meta.lastPage!;
            emit(FavouriteUnitsState(hasMore: hasMore, units: allFavouriteUnits));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }
}
