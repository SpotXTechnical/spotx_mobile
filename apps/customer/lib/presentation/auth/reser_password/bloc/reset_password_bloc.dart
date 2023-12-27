import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/local/shared_prefs_manager.dart';
import 'package:spotx/data/remote/auth/i_auth_repository.dart';
import 'package:spotx/data/remote/auth/models/login_errors_entity.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/presentation/auth/login/bloc/login_event.dart';
import 'package:spotx/presentation/auth/login/bloc/login_state.dart';
import 'package:spotx/presentation/auth/register/register_screen.dart';
import 'package:spotx/presentation/auth/reser_password/bloc/reset_password_event.dart';
import 'package:spotx/presentation/auth/reser_password/bloc/reset_password_state.dart';
import 'package:spotx/presentation/main/main_screen.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/network/api_response.dart';

class ResetPasswordBloc extends BaseBloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc({required this.authRepository}) : super(const ResetPasswordEmptyState()) {
    on<ResetPasswordUser>(_resetPassword);
    on<ResetPasswordHideError>(_hideError);
  }
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();
  final FocusNode repeatPasswordFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final IAuthRepository authRepository;
  static final formKey = GlobalKey<FormState>();

  _resetPassword(ResetPasswordUser event, Emitter<ResetPasswordState> emit) async {
    emit(const ResetPasswordLoading());
    // ApiResponse apiResponse = await authRepository.login(phoneNumberController.text, passwordController.text);
    // await handleResponse(
    //     result: apiResponse,
    //     onSuccess: () {
    //       LoginResponseEntity loginResponseEntity = apiResponse.data.data;
    //       // if (loginResponseEntity.isAuthorized) {
    //       //   emit(const LoginSuccess());
    //       handleAuthorizedUser(loginResponseEntity);
    //       // } else {
    //       //   emit(LoginError(LocaleKeys.noDriverPermission.tr()));
    //       // }
    //     },
    //     onFailed: () {
    //       if (apiResponse.error != null) {
    //         emit(ResetPasswordError(apiResponse.error!.errorMsg));
    //         Future.delayed(const Duration(milliseconds: 30), () => {formKey.currentState?.validate()});
    //       }
    //     });
  }

  _hideError(ResetPasswordHideError event, Emitter<ResetPasswordState> emit) {
    emit(const ResetPasswordEmptyState());
  }

  void handleNavigation() async {
    navigationKey.currentState?.pushNamed(RegisterScreen.tag);
  }
}
