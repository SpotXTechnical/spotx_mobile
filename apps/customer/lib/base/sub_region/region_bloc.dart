import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/base/sub_region/region_event.dart';
import 'package:spotx/base/sub_region/region_state.dart';
import 'package:spotx/data/remote/regions/i_regions_repository.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';

import 'package:spotx/utils/network/api_response.dart';

class SubRegionBloc extends BaseBloc<RegionEvent, RegionState> {
  SubRegionBloc(this.regionsRepository) : super(RegionState()) {
    on<InitRegionsAndSubRegions>(_initRegionsAndSubRegions);
    on<InitSubRegions>(_initSubRegions);
    on<LoadMoreSubRegions>(_loadMoreSubRegions);
    on<AddOrRemoveSelectedSubRegion>(_addOrRemoveSelectedSubRegion);
    on<SetAllSubRegionsSelected>(_setAllSubRegionSelected);
    on<InitRegions>(_initRegions);
    on<LoadMoreRegions>(_loadMoreRegions);
  }
  final IRegionsRepository regionsRepository;

  int page = 1;

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();

  _addOrRemoveSelectedSubRegion(AddOrRemoveSelectedSubRegion event, Emitter<RegionState> emit) async {
    List<Region> selectedSubRegions = List.empty(growable: true);
    state.selectedRegions?.forEach((element) {
      selectedSubRegions.add(element.clone());
    });
    if (selectedSubRegions.map((e) => e.id).toList().contains(event.selectedSubRegion.id)) {
      selectedSubRegions.removeWhere((element) => element.id == event.selectedSubRegion.id);
    } else {
      selectedSubRegions.add(event.selectedSubRegion);
    }
    emit(state.copyWith(selectedRegions: selectedSubRegions, isAllSelected: false));
  }

  _setAllSubRegionSelected(SetAllSubRegionsSelected event, Emitter<RegionState> emit) async {
    emit(state.copyWith(isAllSelected: true, selectedRegions: []));
  }

  _initSubRegions(InitSubRegions event, Emitter<RegionState> emit) async {
    if (event.regionIds != null) {
      page = 1;
      emit(state.copyWith(
          isLoading: true, selectedRegions: event.subregionsList, isAllSelected: event.subregionsList?.isEmpty));
      ApiResponse apiResponse = await regionsRepository.getSubRegions(
          regionsIds: event.regionIds!, page: page, searchQuery: event.searchQuery);

      await handleResponse(
          result: apiResponse,
          onSuccess: () {
            if (apiResponse.data != null) {
              List<Region> subRegions = apiResponse.data.data;
              bool hasMore = apiResponse.data.meta!.total! > subRegions.length;
              if (event.searchQuery == null || event.searchQuery!.isEmpty) {
                emit(state.copyWith(regions: subRegions, hasMoreRegions: hasMore, isLoading: false));
              } else {
                emit(state.copyWith(regions: subRegions,selectedRegions: [], hasMoreRegions: hasMore, isLoading: false));
              }
            }
          },
          onFailed: () {
            if (apiResponse.error != null) {
              emit(state.copyWith(isError: true));
              showErrorMsg(apiResponse.error?.errorMsgKey ?? "Error Occurred in Sub Regions");
            }
          });
    }
  }

  _initRegionsAndSubRegions(InitRegionsAndSubRegions event, Emitter<RegionState> emit) async {
    if (event.regionIds != null) {
      page = 1;
      emit(state.copyWith(
          isLoading: true, selectedRegions: event.subregionsList, isAllSelected: event.subregionsList?.isEmpty));
      ApiResponse apiResponse = await regionsRepository.getRegionsSearch(
        page: page,
        searchQuery: event.searchQuery,
      );

      await handleResponse(
          result: apiResponse,
          onSuccess: () {
            if (apiResponse.data != null) {
              List<Region> subRegions = apiResponse.data.data;
              bool hasMore = apiResponse.data.meta!.total! > subRegions.length;
              emit(state.copyWith(regions: subRegions, hasMoreRegions: hasMore, isLoading: false));
            }
          },
          onFailed: () {
            if (apiResponse.error != null) {
              emit(state.copyWith(isError: true));
              showErrorMsg(apiResponse.error?.errorMsgKey ?? "Error Occurred in Sub Regions");
            }
          });
    }
  }

  _initRegions(InitRegions event, Emitter<RegionState> emit) async {
    page = 1;
    emit(state.copyWith(isLoading: true, isAllSelected: true));
    ApiResponse apiResponse = await regionsRepository.getMostPopularRegionsAndSubRegions(page);

    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Region> regions = apiResponse.data.data;
            bool hasMore = apiResponse.data.meta!.total! > regions.length;
            emit(state.copyWith(regions: regions, hasMoreRegions: hasMore, isLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isError: true));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Error Occurred in Sub Regions");
          }
        });
  }

  _loadMoreRegions(LoadMoreRegions event, Emitter<RegionState> emit) async {
    page++;
    ApiResponse apiResponse = await regionsRepository.getMostPopularRegionsAndSubRegions(page);

    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            if (apiResponse.data != null) {
              List<Region> subRegions = apiResponse.data.data;
              List<Region> allSubRegions = [...?state.regions, ...subRegions];
              bool? hasMore;
              if (apiResponse.data.meta?.total != null) {
                hasMore = apiResponse.data.meta?.total > allSubRegions.length;
              }
              emit(state.copyWith(regions: allSubRegions, hasMoreRegions: hasMore));
            }
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isError: true));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Error Occurred in Sub Regions");
          }
        });
  }

  _loadMoreSubRegions(LoadMoreSubRegions event, Emitter<RegionState> emit) async {
    if (event.regionIds != null) {
      page++;
      ApiResponse apiResponse = await regionsRepository.getSubRegions(regionsIds: event.regionIds!, page: page);

      await handleResponse(
          result: apiResponse,
          onSuccess: () {
            if (apiResponse.data != null) {
              if (apiResponse.data != null) {
                List<Region> subRegions = apiResponse.data.data;
                List<Region> allSubRegions = [...?state.regions, ...subRegions];
                bool? hasMore;
                if (apiResponse.data.meta?.total != null) {
                  hasMore = apiResponse.data.meta?.total > allSubRegions.length;
                }
                emit(state.copyWith(regions: allSubRegions, hasMoreRegions: hasMore));
              }
            }
          },
          onFailed: () {
            if (apiResponse.error != null) {
              emit(state.copyWith(isError: true));
              showErrorMsg(apiResponse.error?.errorMsgKey ?? "Error Occurred in Sub Regions");
            }
          });
    }
  }
}