import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/regions/i_regions_repository.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_state.dart';
import 'package:spotx/utils/network/api_response.dart';

import 'home_event.dart';

class HomeRegionBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeRegionBloc({required this.regionsRepository}) : super(const HomeState()) {
    on<GetRegions>(_getRegions);
    on<UpdateLocale>(_updateLocale);
    on<LogOut>(_logout);
  }

  final IRegionsRepository regionsRepository;

  FutureOr<void> _updateLocale(UpdateLocale event, Emitter<HomeState> emit) {}

  _getRegions(GetRegions event, Emitter<HomeState> emit) async {
    emit(state.copyWith(ourDestinationIsLoading: true));
    ApiResponse apiResponse = await regionsRepository.getRegions(subRegionCount: subRegionCount);

    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<Region> regions = apiResponse.data.data;
            emit(state.copyWith(regions: regions, ourDestinationIsLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isError: true, ourDestinationIsLoading: false));
          }
        });
  }

  FutureOr<void> _logout(LogOut event, Emitter<HomeState> emit) {
    // authRepository.logOutUser();
    // // pop dialog and drawer then logout
    // navigationKey.currentState?.pop();
    // navigationKey.currentState?.pop();
    // navigationKey.currentState?.pushNamedAndRemoveUntil(LoginScreen.tag, (route) => true);
  }
}
