import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/local/shared_prefs_manager.dart';
import 'package:owner/data/remote/auth/i_auth_repository.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/presentation/auth/login/login_screen.dart';
import 'package:owner/presentation/main/screens/profile/bloc/profile_event.dart';
import 'package:owner/presentation/main/screens/profile/bloc/profile_state.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.authRepository) : super(const ProfileState()) {
    on<ProfileCheckIfUserIsLoggedInEvent>(_checkIfLoggedIn);
    on<GetProfileData>(_getProfileData);
    on<LogOutUser>(_logout);
    on<DeleteAccount>(_deleteAccount);
  }
  final IAuthRepository authRepository;

  FutureOr<void> _getProfileData(GetProfileData event, Emitter<ProfileState> emit) async {
    ApiResponse apiResponse = await authRepository.getUser();
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            User user = apiResponse.data.data;
            emit(state.copyWith(user: user));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        }
    );
  }

  FutureOr<void> _logout(LogOutUser event, Emitter<ProfileState> emit) async {
    authRepository.logOutUser();
    navigationKey.currentState?.pushNamedAndRemoveUntil(LoginScreen.tag, (_) => false);
  }

  FutureOr<void> _checkIfLoggedIn(ProfileCheckIfUserIsLoggedInEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isProfileLoading: false, isAuthorized: true, user: User()));
    if (await isLoggedInBefore()) {
      emit(state.copyWith(isError: false));
      add(GetProfileData());
    } else {
      emit(state.copyWith(isAuthorized: false, isProfileLoading: false));
    }
  }

  FutureOr<void> _deleteAccount(DeleteAccount event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isProfileLoading: true,));
    ApiResponse apiResponse = await authRepository.deleteAccount();
    handleResponse(
      result: apiResponse,
      onSuccess: () {
        navigationKey.currentState?.pushNamedAndRemoveUntil(LoginScreen.tag, (_) => false);
        final sharedPrefsManager = Injector().get<SharedPrefsManager>();
        sharedPrefsManager.credentials = null;
      },
      onFailed: () {
        emit(state.copyWith(isProfileLoading: false,));
        if (apiResponse.error != null) {
          showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
        }
      }
    );
  }
}