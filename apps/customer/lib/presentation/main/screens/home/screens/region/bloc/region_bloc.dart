import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/regions/i_regions_repository.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/presentation/main/screens/home/screens/region/bloc/region_event.dart';
import 'package:spotx/presentation/main/screens/home/screens/region/bloc/region_state.dart';
import 'package:spotx/utils/network/api_response.dart';

class RegionBloc extends BaseBloc<RegionEvent, RegionState> {
  RegionBloc(this.regionsRepository) : super(const RegionState()) {
    on<GetSubRegions>(_getSubRegions);
    on<LoadMoreSubRegions>(_loadMoreSubRegions);
    on<SetSelectedSubRegions>(_setSelectedSubRegions);
    on<ManageSubRegionInList>(_manageSubRegionInList);
    on<SetAllSubRegionsSelected>(_setAllSubRegionsSelected);
  }

  final IRegionsRepository regionsRepository;
  int page = 1;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();
  Timer? timer;

  FutureOr<void> _getSubRegions(GetSubRegions event, Emitter<RegionState> emit) async {
    emit(state.copyWith(requestStatus: RequestStatus.loading));
    ApiResponse apiResponse =
        await regionsRepository.getSubRegions(regionsIds: [event.region.id.toString()], searchQuery: event.searchQuery);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Region> subRegions = apiResponse.data.data;
            bool? hasMore;
            if (apiResponse.data.meta?.total != null) {
              hasMore = apiResponse.data.meta?.total > subRegions.length;
            }
            emit(state.copyWith(subRegions: subRegions, hasMore: hasMore, requestStatus: RequestStatus.success));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            state.copyWith(requestStatus: RequestStatus.failure);
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _loadMoreSubRegions(LoadMoreSubRegions event, Emitter<RegionState> emit) async {
    page++;
    ApiResponse apiResponse = await regionsRepository
        .getSubRegions(regionsIds: [event.region.id.toString()], page: page, searchQuery: event.searchQuery);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Region> subRegions = apiResponse.data.data;
            List<Region> allSubRegions = [...?state.subRegions, ...subRegions];
            var meta = apiResponse.data.meta!;
            bool? hasMore = meta.currentPage < meta.lastPage;
            emit(state.copyWith(subRegions: allSubRegions, hasMore: hasMore));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  // todo(add images here)
  List<Region> toSubRegions(List<Region> regions) {
    List<Region> subRegionsList = List.empty(growable: true);
    for (var element in regions) {
      subRegionsList.add(
          Region(id: element.id, name: element.name, description: element.description, subRegions: element.subRegions));
    }
    return subRegionsList;
  }

  FutureOr<void> _setSelectedSubRegions(SetSelectedSubRegions event, Emitter<RegionState> emit) async {
    if (event.selectedSubRegionsIds != null && event.selectedSubRegionsIds!.isNotEmpty) {
      emit(state.copyWith(
          selectedSubRegionsIds: event.selectedSubRegionsIds, selectedSubRegions: event.selectedSubRegions));
    } else {
      emit(state.copyWith(isAllSubRegionsSelected: true));
    }
  }

  FutureOr<void> _setAllSubRegionsSelected(SetAllSubRegionsSelected event, Emitter<RegionState> emit) async {
    emit(state.copyWith(isAllSubRegionsSelected: true, selectedSubRegionsIds: [], selectedSubRegions: []));
  }

  FutureOr<void> _manageSubRegionInList(ManageSubRegionInList event, Emitter<RegionState> emit) async {
    List<int> newSubRegionsIdsList = List.empty(growable: true);
    List<Region> newSubRegionsList = List.empty(growable: true);

    state.selectedSubRegionsIds?.forEach((element) {
      newSubRegionsIdsList.add(element);
    });
    state.selectedSubRegions?.forEach((element) {
      newSubRegionsList.add(element);
    });

    if (newSubRegionsIdsList.contains(event.selectedSubRegionId)) {
      newSubRegionsIdsList.removeWhere((element) => element == event.selectedSubRegionId);
    } else {
      newSubRegionsIdsList.add(event.selectedSubRegionId);
    }

    if (newSubRegionsList.contains(event.selectedSubRegion)) {
      newSubRegionsList.removeWhere((element) => element == event.selectedSubRegion);
    } else {
      newSubRegionsList.add(event.selectedSubRegion!);
    }
    /*  newSubRegionsList = [...?state.selectedSubRegions];
    newSubRegionsList.add(event.selectedSubRegion!);*/
    debugPrint("newSubRegionsList.length ${newSubRegionsList.length}");

    emit(state.copyWith(
        selectedSubRegionsIds: newSubRegionsIdsList,
        isAllSubRegionsSelected: newSubRegionsIdsList.isEmpty,
        selectedSubRegions: newSubRegionsList));
  }
}