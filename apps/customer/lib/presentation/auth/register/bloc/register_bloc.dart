import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/auth/i_auth_repository.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/data/remote/auth/models/register_error_entity.dart';
import 'package:spotx/data/remote/auth/models/register_response_entity.dart';
import 'package:spotx/presentation/auth/register/bloc/register_event.dart';
import 'package:spotx/presentation/auth/register/bloc/register_state.dart';
import 'package:spotx/presentation/main/main_screen.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/utils.dart';

class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  RegisterBloc({required this.authRepository}) : super(const EmptyState()) {
    on<RegisterUser>(_register);
    on<HideError>(_hideError);
    on<SetCity>(_setCity);
    on<SelectUnSelectTerms>(_selectUnSelectTerms);

  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  final IAuthRepository authRepository;
  static final formKey = GlobalKey<FormState>();
  static final cityFormKey = GlobalKey<FormState>();

  _register(RegisterUser event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true, errors: null, generalErrorMessage: null));
    ApiResponse apiResponse = await authRepository.register(nameController.text, emailController.text,
        checkPhoneNumber(phoneController.text), state.city?.id??0, passwordController.text);

    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          RegisterResponseEntity registerResponseEntity = apiResponse.data.data;
          // if (registerResponseEntity.isAuthorized) {
          //   emit(const RegisterSuccess());
          handleAuthorizedUser(registerResponseEntity);
          // } else {
          //   emit(RegisterError(LocaleKeys.noDriverPermission.tr()));
          // }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            RegisterErrorsEntity? registerErrorEntity;
            if (apiResponse.error?.extra != null) {
              registerErrorEntity = RegisterErrorsEntity.fromJson(apiResponse.error?.extra);
            }
            emit(state.copyWith(
                isLoading: false, errors: registerErrorEntity, generalErrorMessage: apiResponse.error?.errorMsg));
            Future.delayed(const Duration(milliseconds: 30), () => {formKey.currentState?.validate()});
          }
        });
  }

  _hideError(HideError event, Emitter<RegisterState> emit) {
    emit(state.copyWith(errors: RegisterErrorsEntity(), generalErrorMessage: "", isLoading: false));
  }

  _setCity(SetCity event, Emitter<RegisterState> emit) async {
    cityController.text = event.city.name!;
    emit(state.copyWith(city: event.city));
    await Future.delayed(const Duration(milliseconds: 100));
    cityFormKey.currentState?.validate();
  }

  void handleAuthorizedUser(RegisterResponseEntity registerResponseEntity) {
    // LoginResponseEntity loginResponseEntity = LoginResponseEntity();
    // LoginResponseData data = LoginResponseData();
    // data.user = registerResponseEntity.user;
    // data.token = registerResponseEntity.token;
    // loginResponseEntity.data = data;
    authRepository
        .saveCredentials(LoginResponseEntity(token: registerResponseEntity.token, user: registerResponseEntity.user));
    // authRepository.updateFirebaseToken();
    // setAnalyticsUser(loginResponseEntity.user);
    navigationKey.currentState?.pushNamedAndRemoveUntil(MainScreen.tag, (_) => false);
  }

  FutureOr<void> _selectUnSelectTerms(SelectUnSelectTerms event, Emitter<RegisterState> emit) {
    emit(state.copyWith(isTermsSelected: event.isSelected));
  }

  void back() {
    navigationKey.currentState?.pop();
  }
}