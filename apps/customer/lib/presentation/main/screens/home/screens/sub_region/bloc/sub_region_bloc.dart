import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/data/remote/regions/regions_repository.dart';
import 'package:spotx/data/remote/unit/i_unit_repository.dart';
import 'package:spotx/data/remote/unit/model/filter_queryies.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/favourite_observing/favourite_list_observer.dart';
import 'package:spotx/favourite_observing/favourite_units_single_tone.dart';
import 'package:spotx/presentation/main/screens/home/screens/sub_region/bloc/sub_region_event.dart';
import 'package:spotx/presentation/main/screens/home/screens/sub_region/bloc/sub_region_state.dart';
import 'package:spotx/utils/network/api_response.dart';

class SubRegionBloc extends BaseBloc<SubRegionEvent, SubRegionState> implements FavouriteListObserver {
  SubRegionBloc(this.unitRepository, this.regionsRepository) : super(const InitialSubRegionState()) {
    FavouriteUnitsSingleTone().subscribe(this);
    on<SubRegionGetUnitsEvent>(_getUnits);
    on<SubRegionLoadMoreUnitsEvent>(_loadMoreFavouriteUnits);
    on<UpdateSubRegionUnitsEvent>(_updateSubRegionUnits);
    on<GetSubRegionEvent>(_getSubRegion);
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        add(SubRegionLoadMoreUnitsEvent(subRegionId));
      }
    });
  }
  int page = 1;
  final IUnitRepository unitRepository;
  final RegionsRepository regionsRepository;
  ScrollController scrollController = ScrollController();
  int subRegionId = 0;
  _getUnits(SubRegionGetUnitsEvent event, Emitter<SubRegionState> emit) async {
    subRegionId = event.subRegionId;
    await initiateList(event, emit);
  }

  _getSubRegion(GetSubRegionEvent event, Emitter<SubRegionState> emit) async {
    emit(state.copyWith(isSubRegionLoading: true));
    final apiResponse = await regionsRepository.getRegion(event.subRegionId);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            Region region = apiResponse.data.data;
            emit(state.copyWith(subRegion: region, isSubRegionLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(const InitialSubRegionState());
          }
        });
  }

  _updateSubRegionUnits(UpdateSubRegionUnitsEvent event, Emitter<SubRegionState> emit) async {
    emit(SubRegionState(units: event.units, isUnitsLoading: state.isUnitsLoading, hasMore: state.hasMore));
  }

  FutureOr<void> initiateList(SubRegionGetUnitsEvent event, Emitter<SubRegionState> emit) async {
    emit(state.copyWith(isUnitsLoading: true));

    final subRegion = Region(id: event.subRegionId);
    ApiResponse apiResponse = await unitRepository.getUnits(FilterQueries(regions: List.of([subRegion])));
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
            emit(const InitialSubRegionState());
          }
        });
  }

  FutureOr<void> _loadMoreFavouriteUnits(SubRegionLoadMoreUnitsEvent event, Emitter<SubRegionState> emit) async {
    page++;
    final subRegion = Region(id: event.subRegionId);
    ApiResponse apiResponse = await unitRepository.getUnits(FilterQueries(regions: List.of([subRegion]), page: page));
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
    add(UpdateSubRegionUnitsEvent(newUnitList));
  }

  @override
  Future<void> close() {
    FavouriteUnitsSingleTone().unSubscribe(this);
    return super.close();
  }
}