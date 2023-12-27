import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/auth/i_auth_repository.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_event.dart';
import 'package:spotx/presentation/main/screens/home/bloc/home_state.dart';
import 'package:spotx/utils/network/api_response.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc(this.authRepository) : super(const HomeState()) {
    on<HomeGetProfileData>(_getProfileData);
  }

  final IAuthRepository authRepository;

  _getProfileData(HomeGetProfileData event, Emitter<HomeState> emit) async {
    ApiResponse apiResponse = await authRepository.getProfile();
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          User userData = apiResponse.data.data;
          emit(state.copyWith(user: userData));
        },
        onFailed: () {
          if (apiResponse.error != null) {}
        });
  }
}