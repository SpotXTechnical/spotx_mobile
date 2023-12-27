import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/local/shared_prefs_manager.dart';
import 'package:spotx/data/remote/auth/i_auth_repository.dart';
import 'package:spotx/data/remote/auth/models/get_cities_response_entity.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/data/remote/auth/models/register_error_entity.dart';
import 'package:spotx/presentation/main/screens/profile/screens/edit_profile/bloc/edit_profile_event.dart';
import 'package:spotx/presentation/main/screens/profile/screens/edit_profile/bloc/edit_profile_state.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/utils.dart';

import '../../../../../../../utils/network/api_response.dart';

class EditProfileBloc extends BaseBloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc({required this.authRepository}) : super(const EmptyState()) {
    on<UpdateProfile>(updateProfile);
    on<HideError>(_hideError);
    on<SetCity>(_setCity);
    on<SetImage>(_setImage);
    on<InitUser>(_initUser);
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();

  final IAuthRepository authRepository;
  static final formKey = GlobalKey<FormState>();
  static final cityFormKey = GlobalKey<FormState>();

  updateProfile(UpdateProfile event, Emitter<EditProfileState> emit) async {
    emit(state.copyWith(isLoading: true, errors: null, generalErrorMessage: null));
    ApiResponse apiResponse = await authRepository.updateProfile(nameController.text, emailController.text,
        checkPhoneNumber(phoneController.text), state.city?.id?.toString()??'', state.image);
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          User user = apiResponse.data.data;
          var loggedInCredentials = Injector().get<SharedPrefsManager>().credentials;
          loggedInCredentials?.user = user;
          authRepository.saveCredentials(loggedInCredentials!);
          navigationKey.currentState?.pop(true);
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

  _hideError(HideError event, Emitter<EditProfileState> emit) {
    if (state.city != null) {
      emit(state.copyWith(errors: RegisterErrorsEntity(), generalErrorMessage: "", isLoading: false));
    }
  }

  _setCity(SetCity event, Emitter<EditProfileState> emit) async {
    cityController.text = event.city.name!;
    emit(state.copyWith(city: event.city));
    await Future.delayed(const Duration(milliseconds: 100));
    EditProfileBloc.cityFormKey.currentState?.validate();
  }

  _initUser(InitUser event, Emitter<EditProfileState> emit) async {
    nameController.text = event.user.name!;
    emailController.text = event.user.email!;
    phoneController.text = removeCountryCode(event.user.phone!);
    var city = City();
    city.id = event.user.cityId;
    emit(state.copyWith(city: city, networkImage: event.user.image));
  }

  _setImage(SetImage event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(image: event.image));
  }

  String removeCountryCode(String phone) {
    return phone.substring(2, phone.length);
  }

  bool isDataChanged() {
    var loggedInCredentials = Injector().get<SharedPrefsManager>().credentials;
    var user = loggedInCredentials?.user;
    bool isDataChanged = false;
    if (checkPhoneNumber(phoneController.text) != user?.phone) {
      isDataChanged = true;
    }
    if (nameController.text != user?.name) {
      isDataChanged = true;
    }
    if (emailController.text != user?.email) {
      isDataChanged = true;
    }
    if (cityController.text != user?.city?.name) {
      isDataChanged = true;
    }
    if (state.image != null) {
      isDataChanged = true;
    }
    return isDataChanged;
  }
}
