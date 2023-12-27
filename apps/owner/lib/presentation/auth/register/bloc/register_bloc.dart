import 'dart:async';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/auth/i_auth_repository.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/data/remote/auth/models/register_error_entity.dart';
import 'package:owner/data/remote/auth/models/register_response_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/auth/register/bloc/register_event.dart';
import 'package:owner/presentation/auth/register/bloc/register_state.dart';
import 'package:owner/presentation/main/main_screen.dart';
import 'package:owner/utils/analytics/analytics_keys.dart';
import 'package:owner/utils/analytics/i_analytics.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/remote_config/remote_config.dart';

class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  RegisterBloc({required this.authRepository}) : super(const EmptyState()) {
    on<RegisterUser>(_register);
    on<HideError>(_hideError);
    on<RegisterAddImage>(_addImage);
    on<RegisterAddNationalIdImage>(_addNationalIdImage);
    on<RegisterRemoveNationalIdImage>(_removeNationalIdImage);
    on<RegisterSelectUserTypeEvent>(_selectUserType);
    on<ValidateImages>(_validateImages);
    on<SelectUnSelectTerms>(_selectUnSelectTerms);
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nationIdController = TextEditingController();
  final TextEditingController whatsAppController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();
  final FocusNode nationIdFocus = FocusNode();
  final FocusNode whatsAppFocus = FocusNode();

  final IAuthRepository authRepository;
  static final formKey = GlobalKey<FormState>();

  _register(RegisterUser event, Emitter<RegisterState> emit) async {
    if (state.imageFile == null) {
      emit(state.copyWith(personalImageErrorMessage: LocaleKeys.personalImageErrorMsg.tr()));
    } else if (state.nationalIdImageFile == null && showNationalIdentity()) {
      emit(state.copyWith(nationalIdErrorMessage: LocaleKeys.nationalIdErrorMsg.tr()));
    } else if(state.isTermsSelected == false) {
      emit(state.copyWith(nationalIdErrorMessage: LocaleKeys.termsConditionsErrorMsg.tr()));
    } else {
      emit(state.copyWith(isLoading: true, errors: null, generalErrorMessage: null));
      ApiResponse apiResponse = await authRepository.register(
          nameController.text,
          emailController.text,
          checkPhoneNumber(phoneController.text),
          passwordController.text,
          state.userType.name,
          state.imageFile!,
          nationIdController.text,
          state.nationalIdImageFile ?? state.imageFile!,
          checkPhoneNumber(whatsAppController.text)
      );
      await handleResponse(
          result: apiResponse,
          onSuccess: () {
            RegisterResponseEntity registerResponseEntity = apiResponse.data.data;
            handleAuthorizedUser(registerResponseEntity);
          },
          onFailed: () {
            if (apiResponse.error != null) {
              RegisterErrorsEntity? registerErrorEntity;
              if (apiResponse.error?.extra != null) {
                registerErrorEntity = RegisterErrorsEntity.fromJson(apiResponse.error?.extra);
              }
              emit(state.copyWith(
                  isLoading: false,
                  errors: registerErrorEntity,
                  generalErrorMessage: apiResponse.error?.errorMsg,
                  personalImageErrorMessage: registerErrorEntity?.image?.first,
                  nationalIdErrorMessage: registerErrorEntity?.nationalIdImage?.first));
              Future.delayed(const Duration(milliseconds: 30), () => {formKey.currentState?.validate()});
            }
          }
      );
    }
  }

  _hideError(HideError event, Emitter<RegisterState> emit) {
    emit(state.copyWith(errors: RegisterErrorsEntity(), generalErrorMessage: "", isLoading: false));
  }

  _validateImages(ValidateImages event, Emitter<RegisterState> emit) {
    if (state.nationalIdImageFile == null) {
      emit(state.copyWith(nationalIdErrorMessage: LocaleKeys.required.tr()));
    } else {
      emit(state.copyWith(nationalIdErrorMessage: ""));
    }
    if (state.personalImageErrorMessage == null) {
      emit(state.copyWith(personalImageErrorMessage: LocaleKeys.required.tr()));
    } else {
      emit(state.copyWith(personalImageErrorMessage: ""));
    }
  }

  _addImage(RegisterAddImage event, Emitter<RegisterState> emit) {
    emit(state.copyWith(imageFile: event.imageFile, personalImageErrorMessage: ""));
  }

  _addNationalIdImage(RegisterAddNationalIdImage event, Emitter<RegisterState> emit) {
    emit(state.copyWith(nationalIdImageFile: event.imageFile, nationalIdErrorMessage: ""));
  }

  _selectUserType(RegisterSelectUserTypeEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(userType: event.userType));
  }

  void handleAuthorizedUser(RegisterResponseEntity registerResponseEntity) {
    LoginResponseEntity loginResponseEntity = LoginResponseEntity();
    loginResponseEntity.user = registerResponseEntity.user;
    loginResponseEntity.token = registerResponseEntity.token;
    authRepository.saveCredentials(loginResponseEntity);
    authRepository.updateFirebaseToken();
    if(loginResponseEntity.user != null) {
      setAnalyticsUser(loginResponseEntity.user!);
    }
    navigationKey.currentState?.pushNamedAndRemoveUntil(MainScreen.tag, (_) => false);
  }

  void back() {
    navigationKey.currentState?.pop();
  }

  String checkPhoneNumber(String phone) {
    if (phone.startsWith("+2")) {
      return phone;
    } else {
      return "+2$phone";
    }
  }

  FutureOr<void> _removeNationalIdImage(RegisterRemoveNationalIdImage event, Emitter<RegisterState> emit) {
    emit(RegisterState(
      errors: state.errors,
      generalErrorMessage: state.generalErrorMessage,
      imageFile: state.imageFile,
      isLoading: state.isLoading,
      personalImageErrorMessage: state.personalImageErrorMessage,
      userType: state.userType
    ));
  }

  void setAnalyticsUser(User user) {
    IAnalytics analytics = Injector().get<IAnalytics>();
    analytics.setUserId(user.id.toString());
    analytics.setUserProperty(name: UserIdentity.userName, value: user.name??'');
    analytics.setUserProperty(name: UserIdentity.userPhone, value: user.phone??'');
    analytics.setUserProperty(name: UserIdentity.userWhats, value: user.whatsApp??'');
    analytics.setUserProperty(name: UserIdentity.userEmail, value: user.email??'');
  }

  FutureOr<void> _selectUnSelectTerms(SelectUnSelectTerms event, Emitter<RegisterState> emit) {
    emit(state.copyWith(isTermsSelected: event.isSelected));
  }

  bool showNationalIdentity() {
    return getRCBool(key: RemoteConfigKeys.showNationalIdentity);
  }
}
