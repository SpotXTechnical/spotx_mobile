import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/base/sub_region/sub_region_event.dart';
import 'package:owner/base/sub_region/sub_region_state.dart';
import 'package:owner/data/remote/region/i_region_repository.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';

import 'package:owner/utils/network/api_response.dart';

class SubRegionBloc extends BaseBloc<SubregionEvent, SubRegionState> {
  SubRegionBloc(this.regionsRepository) : super(SubRegionState()) {
    on<GetSubRegions>(_getSubRegions);
    on<LoadMoreSubRegions>(_loadMoreSubRegions);
  }
  final IRegionRepository regionsRepository;

  int page = 1;

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();

  _getSubRegions(GetSubRegions event, Emitter<SubRegionState> emit) async {
    page = 1;
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse =
        await regionsRepository.getSubRegions(regionsIds: [event.regionId], page: page, searchQuery: event.searchQuery);

    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Region> subRegions = apiResponse.data.data;
            bool hasMore = apiResponse.data.meta!.total! > subRegions.length;
            emit(state.copyWith(subRegions: subRegions, hasMoreSubRegions: hasMore, isLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isError: true));
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Error Occurred in Sub Regions");
          }
        });
  }

  _loadMoreSubRegions(LoadMoreSubRegions event, Emitter<SubRegionState> emit) async {
    page++;
    ApiResponse apiResponse = await regionsRepository.getSubRegions(regionsIds: [event.regionId], page: page);

    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            if (apiResponse.data != null) {
              List<Region> subRegions = apiResponse.data.data;
              List<Region> allSubRegions = [...?state.subRegions, ...subRegions];
              bool? hasMore;
              if (apiResponse.data.meta?.total != null) {
                hasMore = apiResponse.data.meta?.total > allSubRegions.length;
              }
              emit(state.copyWith(subRegions: allSubRegions, hasMoreSubRegions: hasMore));
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
