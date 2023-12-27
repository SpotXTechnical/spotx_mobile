import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/local/shared_prefs_manager.dart';
import 'package:spotx/data/remote/auth/i_auth_repository.dart';
import 'package:spotx/data/remote/auth/models/company_code_entity.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/login_observing/login_observer.dart';
import 'package:spotx/login_observing/login_single_tone.dart';
import 'package:spotx/presentation/auth/login/login_screen.dart';
import 'package:spotx/presentation/main/main_screen.dart';
import 'package:spotx/presentation/main/screens/profile/bloc/profile_event.dart';
import 'package:spotx/presentation/main/screens/profile/bloc/profile_state.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/network/api_response.dart';

class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState>
    implements LoginObserver {
  ProfileBloc(this.authRepository) : super(const ProfileState()) {
    LoginSingleTone().subscribe(this);
    on<ProfileCheckIfUserIsLoggedInEvent>(_checkIfLoggedIn);
    on<GetProfileData>(_getProfileData);
    on<LogOutUser>(_logout);
    on<DeleteAccount>(_deleteAccount);
    on<ApplyCompanyCode>(_applyCompanyCode);
  }

  final IAuthRepository authRepository;
  final applyCodeController = TextEditingController();
  static const tag = "ProfileBloc";

  @override
  String? observerName = tag;

  @override
  void update() {
    add(ProfileCheckIfUserIsLoggedInEvent());
  }

  FutureOr<void> _getProfileData(GetProfileData event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isProfileLoading: true));
    ApiResponse apiResponse = await authRepository.getProfile();
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          User userData = apiResponse.data.data;
          var loggedInCredentials = Injector().get<SharedPrefsManager>().credentials;
          loggedInCredentials?.user = userData;
          authRepository.saveCredentials(loggedInCredentials!);
          emit(state.copyWith(user: userData, isProfileLoading: false));
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(const ProfileState(isError: true, isProfileLoading: false));
          }
        });
  }

  FutureOr<void> _logout(LogOutUser event, Emitter<ProfileState> emit) async {
    await authRepository.logOutUser();
    navigationKey.currentState?.pushNamedAndRemoveUntil(MainScreen.tag, (_) => false);
  }

  FutureOr<void> _checkIfLoggedIn(ProfileCheckIfUserIsLoggedInEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isProfileLoading: true, isAuthorized: true));
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
          navigationKey.currentState
              ?.pushNamedAndRemoveUntil(LoginScreen.tag, (_) => false);
          final sharedPrefsManager = Injector().get<SharedPrefsManager>();
          sharedPrefsManager.credentials = null;
        },
        onFailed: () {
          emit(state.copyWith(isProfileLoading: false,));
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  FutureOr<void> _applyCompanyCode(
    ApplyCompanyCode event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isCodeLoading: true));
    ApiResponse apiResponse = await authRepository.applyCompanyCodeService(
      applyCodeController.text,
    );
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          CompanyCodeEntity userData = apiResponse.data.data;
          emit(state.copyWith(isCodeLoading: false, user: userData.user));
        },
        onFailed: () {
          emit(state.copyWith(isCodeLoading: false));
          showErrorMsg(apiResponse.error?.errorMsg ??
              "Some thing Error has been happened");
        });
  }

  @override
  Future<void> close() {
    LoginSingleTone().unSubscribe(this);
    return super.close();
  }
}