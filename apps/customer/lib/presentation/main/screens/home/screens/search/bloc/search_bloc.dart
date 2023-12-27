import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/regions/i_regions_repository.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/data/remote/unit/i_unit_repository.dart';
import 'package:spotx/data/remote/unit/model/filter_queryies.dart';
import 'package:spotx/data/remote/unit/model/unit_filter_config_entity.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/favourite_observing/favourite_list_observer.dart';
import 'package:spotx/favourite_observing/favourite_units_single_tone.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/bloc/search_event.dart';
import 'package:spotx/presentation/main/screens/home/screens/search/bloc/search_state.dart';
import 'package:spotx/utils/const.dart';
import 'package:spotx/utils/network/api_response.dart';

class SearchBloc extends BaseBloc<SearchEvent, SearchState> implements FavouriteListObserver {
  SearchBloc(this.unitRepository, this.regionsRepository) : super(const InitialSearchState()) {
    FavouriteUnitsSingleTone().subscribe(this);
    on<GetUnits>(_getUnits);
    on<LoadMoreUnits>(_loadMoreUnits);
    on<UpdateSearchUnitsEvent>(_updateMostPopularState);
  }
  int page = 1;
  final IUnitRepository unitRepository;
  final IRegionsRepository regionsRepository;

  _getUnits(GetUnits event, Emitter<SearchState> emit) async {
    emit(state.copyWith(isLoading: true, selectedRegions: event.filterQueries?.regions));
    if (event.filterQueries != null) {
      await initiateList(emit, updateSortType(event.filterQueries!));
    } else {
      List<ApiResponse> apiResponses = await unitRepository.getFilterData();
      await handleMultipleResponse(
          result: apiResponses,
          onSuccess: () async {
            List<Region> regions = apiResponses[0].data.data;
            UnitFilterConfigEntity filterConfigEntity = apiResponses[1].data.data;
            FilterQueries filterQueries = FilterQueries(
              minRooms: getDefaultRoomNumbers(filterConfigEntity),
              minBeds: getDefaultBedNumbers(filterConfigEntity),
              regions: regions.map((e) => e).toList(),
              minPrice: filterConfigEntity.minPrice.toString(),
              maxPrice: filterConfigEntity.maxPrice.toString(),
            );
            await initiateList(emit, updateSortType(filterQueries));
          },
          onFailed: () {
            emit(state.copyWith(isError: true, isLoading: false));
          });
    }
  }

  List<int> getDefaultBedNumbers(UnitFilterConfigEntity data) {
    var selectedBedsNumbers = List<int>.empty(growable: true);
    for (var i = 1; i <= data.maxBeds!; i++) {
      selectedBedsNumbers.add(i);
    }
    return selectedBedsNumbers;
  }

  List<int> getDefaultRoomNumbers(UnitFilterConfigEntity data) {
    var selectedRoomsNumbers = List<int>.empty(growable: true);
    for (var i = 1; i <= data.maxRooms!; i++) {
      selectedRoomsNumbers.add(i);
    }
    return selectedRoomsNumbers;
  }

  _updateMostPopularState(UpdateSearchUnitsEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(units: event.units, hasMore: state.hasMore, filterQueries: state.filterQueries));
  }

  FutureOr<void> initiateList(Emitter<SearchState> emit, FilterQueries filterQueries) async {
    emit(state.copyWith(isLoading: true, regions: state.regions));
    ApiResponse apiResponse = await unitRepository.getUnits(filterQueries);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Unit> units = apiResponse.data.data;
            bool hasMore = apiResponse.data.meta!.total! > units.length;
            emit(state.copyWith(
                units: units,
                hasMore: hasMore,
                filterQueries: filterQueries,
                isLoading: false,
                isError: false,
                regions: state.regions));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isRegionListError: true, isRegionListLoading: false, isError: true, isLoading: false));
          }
        });
  }

  FutureOr<void> _loadMoreUnits(LoadMoreUnits event, Emitter<SearchState> emit) async {
    FilterQueries? filterQueries = state.filterQueries;
    page++;
    filterQueries?.page = page;
    state.copyWith(filterQueries: filterQueries);
    ApiResponse apiResponse = await unitRepository.getUnits(filterQueries!);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Unit> units = apiResponse.data.data;
            List<Unit> allUnits = [...?state.units, ...units];
            var meta = apiResponse.data.meta!;
            bool hasMore = meta.currentPage! < meta.lastPage!;
            emit(state.copyWith(
                units: allUnits, hasMore: hasMore, filterQueries: filterQueries, regions: state.regions));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FilterQueries updateSortType(FilterQueries filterQueries) {
    switch (filterQueries.sortType) {
      case lowToHighPrice:
        filterQueries.orderBy = orderByDefaultPrice;
        filterQueries.orderType = ascOrderType;
        break;
      case highToLowPrice:
        filterQueries.orderBy = orderByDefaultPrice;
        filterQueries.orderType = descOrderType;
        break;
      case latest:
        filterQueries.orderBy = orderByCreatedAt;
        filterQueries.orderType = descOrderType;
        break;
    }
    return filterQueries;
  }

  @override
  void update() {
    List<Unit> newUnitList = Unit.createNewUnitList(state.units);
    FavouriteUnitsSingleTone().updateUnitsList(newUnitList);
    add(UpdateSearchUnitsEvent(newUnitList));
  }

  @override
  Future<void> close() {
    FavouriteUnitsSingleTone().unSubscribe(this);
    return super.close();
  }
}