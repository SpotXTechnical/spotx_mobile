import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/unit/i_unit_repository.dart';
import 'package:spotx/data/remote/unit/model/filter_queryies.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/favourite_observing/favourite_list_observer.dart';
import 'package:spotx/favourite_observing/favourite_units_single_tone.dart';
import 'package:spotx/presentation/owner_profile/bloc/owner_profile_event.dart';
import 'package:spotx/presentation/owner_profile/bloc/owner_profile_state.dart';
import 'package:spotx/utils/network/api_response.dart';

class OwnerProfileBloc extends BaseBloc<OwnerProfileEvent, OwnerProfileState> implements FavouriteListObserver {
  OwnerProfileBloc(this.unitRepository) : super(const OwnerProfileState()) {
    FavouriteUnitsSingleTone().subscribe(this);
    on<GetOwnerProfileOwner>(_getOwner);
    on<GetOwnerUnits>(_getOwnerUnits);
    on<OwnerMoreUnitsEvent>(_loadMoreOwnerUnits);
    on<UpdateOwnerUnitsEvent>(_updateOwnerUnits);
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        add(OwnerMoreUnitsEvent());
      }
    });
  }
  int page = 1;
  int subRegionId = 0;
  final IUnitRepository unitRepository;
  ScrollController scrollController = ScrollController();
  _updateOwnerUnits(UpdateOwnerUnitsEvent event, Emitter<OwnerProfileState> emit) async {
    emit(state.copyWith(units: event.units));
  }

  FutureOr<void> _getOwner(GetOwnerProfileOwner event, Emitter<OwnerProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await unitRepository.getOwner(event.ownerId);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            Owner owner = apiResponse.data.data;
            emit(state.copyWith(isLoading: false, owner: owner));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isLoading: false));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  _getOwnerUnits(GetOwnerUnits event, Emitter<OwnerProfileState> emit) async {
    await initiateList(event, emit);
  }

  FutureOr<void> initiateList(GetOwnerUnits event, Emitter<OwnerProfileState> emit) async {
    emit(state.copyWith(isUnitsLoading: true));
    ApiResponse apiResponse = await unitRepository.getUnits(FilterQueries(page: page, ownerId: event.ownerId));
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Unit> units = apiResponse.data.data;
            bool hasMore = apiResponse.data.meta!.total! > units.length;
            emit(state.copyWith(units: units, hasMore: hasMore, isUnitsLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _loadMoreOwnerUnits(OwnerMoreUnitsEvent event, Emitter<OwnerProfileState> emit) async {
    page++;
    ApiResponse apiResponse = await unitRepository.getUnits(FilterQueries(page: page, ownerId: state.owner!.id.toString()));
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Unit> units = apiResponse.data.data;
            List<Unit> allUnits = [...?state.units, ...units];
            var meta = apiResponse.data.meta!;
            bool hasMore = meta.currentPage! < meta.lastPage!;
            emit(state.copyWith(units: allUnits, hasMore: hasMore));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  @override
  void update() {
    List<Unit> newUnitList = Unit.createNewUnitList(state.units);
    FavouriteUnitsSingleTone().updateUnitsList(newUnitList);
    add(UpdateOwnerUnitsEvent(newUnitList));
  }

  @override
  Future<void> close() {
    FavouriteUnitsSingleTone().unSubscribe(this);
    return super.close();
  }
}
