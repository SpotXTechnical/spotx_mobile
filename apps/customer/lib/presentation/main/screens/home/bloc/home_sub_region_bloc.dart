import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/regions/i_regions_repository.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_event.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_state.dart';
import 'package:spotx/utils/network/api_response.dart';

class HomeSubRegionBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeSubRegionBloc({required this.regionRepository}) : super(const HomeState()) {
    on<GetSubRegions>(_getSubRegions);
    on<UpdateLocale>(_updateLocale);
  }

  final IRegionsRepository regionRepository;

  FutureOr<void> _updateLocale(UpdateLocale event, Emitter<HomeState> emit) {}

  _getSubRegions(GetSubRegions event, Emitter<HomeState> emit) async {
    emit(state.copyWith(subRegionsSectionIsLoading: true));
    ApiResponse apiResponse =
        await regionRepository.getRegions(withSubRegions: withSubRegion, mostPopular: isMostPopular);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Region> subRegions = apiResponse.data.data;
            //Region subRegion = apiResponse.data.data;
            emit(state.copyWith(mostPopularRegions: subRegions, subRegionsSectionIsLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isError: true, subRegionsSectionIsLoading: true));
          }
        });
  }
}
