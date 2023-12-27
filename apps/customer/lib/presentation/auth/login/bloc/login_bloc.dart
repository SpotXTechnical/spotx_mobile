import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/auth/i_auth_repository.dart';
import 'package:spotx/data/remote/auth/models/login_errors_entity.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/login_observing/login_single_tone.dart';
import 'package:spotx/presentation/auth/login/bloc/login_event.dart';
import 'package:spotx/presentation/auth/login/bloc/login_state.dart';
import 'package:spotx/presentation/auth/register/register_screen.dart';
import 'package:spotx/presentation/main/main_screen.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/network/api_response.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc({required this.authRepository}) : super(const EmptyState()) {
    on<LoginUser>(_login);
    on<HideError>(_hideError);
  }

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final IAuthRepository authRepository;
  static final formKey = GlobalKey<FormState>();

  _login(LoginUser event, Emitter<LoginState> emit) async {
    emit(const LoginLoading());
    ApiResponse apiResponse =
        await authRepository.login(checkPhoneNumber(phoneNumberController.text), passwordController.text);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          LoginResponseEntity loginResponseEntity = apiResponse.data.data;
          // if (loginResponseEntity.isAuthorized) {
          //   emit(const LoginSuccess());
          handleAuthorizedUser(loginResponseEntity, event.isShowingSkip);
          // } else {
          //   emit(LoginError(LocaleKeys.noDriverPermission.tr()));
          // }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            LoginErrorsEntity? loginErrorsEntity;
            if (apiResponse.error?.extra != null) {
              loginErrorsEntity = LoginErrorsEntity.fromJson(apiResponse.error?.extra);
            }
            emit(LoginError(loginErrorsEntity, apiResponse.error?.errorMsg));
            Future.delayed(const Duration(milliseconds: 30), () => {formKey.currentState?.validate()});
          }
        });
  }

  _hideError(HideError event, Emitter<LoginState> emit) {
    emit(const EmptyState());
  }

  void handleAuthorizedUser(LoginResponseEntity loginResponseEntity, bool? isShowingSkip) {
    authRepository.saveCredentials(loginResponseEntity);
    authRepository.updateFirebaseToken();
    // setAnalyticsUser(loginResponseEntity.user);
    //TODO()
    if (isShowingSkip != null && isShowingSkip) {
      LoginSingleTone().notify();
      navigationKey.currentState?.pop(true);
      // receive index , go to main then show index
    } else {
      navigationKey.currentState?.pushNamedAndRemoveUntil(MainScreen.tag, (_) => false);
    }
  }

  void handleNavigation() async {
    navigationKey.currentState?.pushNamed(RegisterScreen.tag);
  }

  String checkPhoneNumber(String phone) {
    if (phone.startsWith("+2")) {
      return phone;
    } else {
      return "+2$phone";
    }
  }
}