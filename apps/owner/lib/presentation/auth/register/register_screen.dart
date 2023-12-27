import 'dart:io';
import 'package:easy_localization/src/public_ext.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/auth/auth_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/auth/register/bloc/register_bloc.dart';
import 'package:owner/presentation/auth/register/bloc/register_event.dart';
import 'package:owner/presentation/auth/register/widgets/register_national_id_image.dart';
import 'package:owner/presentation/auth/register/widgets/register_personal_image.dart';
import 'package:owner/presentation/auth/register/widgets/register_sign_up_button.dart';
import 'package:owner/presentation/auth/register/widgets/terms_conditions_checkbox_widget.dart';
import 'package:owner/utils/remote_config/remote_config.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';
import 'package:owner/presentation/auth/register/widgets/register_user_type_widget.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/header.dart';
import 'bloc/register_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const tag = "RegisterWidget";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (ctx) => RegisterBloc(authRepository: AuthRepository()),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          RegisterBloc registerBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              appBar: Header(
                title: LocaleKeys.signUp.tr(),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: RegisterBloc.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RegisterPersonalImage(
                          addSingleImage: (mediaFile) {
                            registerBloc.add(RegisterAddImage(File(mediaFile.path!)));
                          },
                          imageFile: state.imageFile,
                        ),
                        ((state.personalImageErrorMessage != null && state.personalImageErrorMessage != "")
                            ? Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Text(
                                  state.personalImageErrorMessage!,
                                  style: errorTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Container()),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          child: Text(
                            LocaleKeys.userType.tr(),
                            style: circularMedium(color: Theme.of(context).hintColor, fontSize: 14),
                          ),
                        ),
                        UserTypeWidget(
                            userType: state.userType,
                            setUserType: (userType) {
                              if (state.userType != userType) {
                                registerBloc.add(RegisterSelectUserTypeEvent(userType));
                              }
                            }),
                        CustomTitledRoundedTextFormWidget(
                          controller: registerBloc.nameController,
                          hintText: LocaleKeys.enterYourName.tr(),
                          title: LocaleKeys.name.tr(),
                          keyboardType: TextInputType.text,
                          focusNode: registerBloc.nameFocus,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (name) {
                            registerBloc.nameFocus.unfocus();
                            FocusScope.of(context).requestFocus(registerBloc.emailFocus);
                          },
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return LocaleKeys.validationInsertData.tr();
                            } else if (state.errors != null && state.errors?.name != null) {
                              return state.errors?.name?.first;
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomTitledRoundedTextFormWidget(
                          controller: registerBloc.emailController,
                          hintText: LocaleKeys.enterYourEmail.tr(),
                          title: LocaleKeys.email.tr(),
                          focusNode: registerBloc.emailFocus,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (email) {
                            registerBloc.emailFocus.unfocus();
                            FocusScope.of(context).requestFocus(registerBloc.phoneFocus);
                          },
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return LocaleKeys.validationInsertData.tr();
                            } else if (!EmailValidator.validate(value ?? '')) {
                              return LocaleKeys.emailValidationInsertMsg.tr();
                            } else if (state.errors != null && state.errors?.email != null) {
                              return state.errors?.email?.first;
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomTitledRoundedTextFormWidget(
                          controller: registerBloc.phoneController,
                          hintText: LocaleKeys.enterYourPhoneNumber.tr(),
                          title: LocaleKeys.phoneNumber.tr(),
                          keyboardType: TextInputType.number,
                          focusNode: registerBloc.phoneFocus,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (phone) {
                            registerBloc.phoneFocus.unfocus();
                            FocusScope.of(context).requestFocus(registerBloc.passwordFocus);
                          },
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return LocaleKeys.validationInsertData.tr();
                            } else if (!isNotStartWithCountryCode(value!) && !isStartByCountryCode(value)) {
                              return LocaleKeys.phoneValidationMessage.tr();
                            } else if (state.errors != null && state.errors?.phone != null) {
                              return state.errors?.phone?.first;
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomTitledRoundedTextFormWidget(
                          controller: registerBloc.passwordController,
                          hintText: LocaleKeys.enterYourPassword.tr(),
                          title: LocaleKeys.password.tr(),
                          focusNode: registerBloc.passwordFocus,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          hidePassword: true,
                          obscureText: true,
                          onFieldSubmitted: (password) {
                            registerBloc.passwordFocus.unfocus();
                            FocusScope.of(context).requestFocus(registerBloc.confirmPasswordFocus);
                          },
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return LocaleKeys.validationInsertData.tr();
                            } else if (state.errors != null && state.errors?.password != null) {
                              return state.errors?.password?.first;
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomTitledRoundedTextFormWidget(
                          controller: registerBloc.confirmPasswordController,
                          hintText: LocaleKeys.enterYourPassword.tr(),
                          title: LocaleKeys.confirmPassword.tr(),
                          obscureText: true,
                          hidePassword: true,
                          keyboardType: TextInputType.visiblePassword,
                          focusNode: registerBloc.confirmPasswordFocus,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (phone) {
                            registerBloc.confirmPasswordFocus.unfocus();
                            FocusScope.of(context).requestFocus(registerBloc.whatsAppFocus);
                          },
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return LocaleKeys.validationInsertData.tr();
                            } else if (registerBloc.passwordController.text.isNotEmpty &&
                                registerBloc.passwordController.text != registerBloc.confirmPasswordController.text) {
                              return LocaleKeys.passwordMismatchMessage.tr();
                            } else {
                              return null;
                            }
                          },
                        ),
                        CustomTitledRoundedTextFormWidget(
                          controller: registerBloc.whatsAppController,
                          hintText: LocaleKeys.enterWhatsAppNumber.tr(),
                          title: LocaleKeys.whatsAppNumber.tr(),
                          keyboardType: TextInputType.number,
                          focusNode: registerBloc.whatsAppFocus,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (phone) {
                            registerBloc.whatsAppFocus.unfocus();
                            FocusScope.of(context).requestFocus(registerBloc.nationIdFocus);
                          },
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return LocaleKeys.validationInsertData.tr();
                            } else if (!isNotStartWithCountryCode(value!) && !isStartByCountryCode(value)) {
                              return LocaleKeys.phoneValidationMessage.tr();
                            } else if (state.errors != null && state.errors?.whatApp != null) {
                              return state.errors?.whatApp?.first;
                            } else {
                              return null;
                            }
                          },
                        ),
                        /*CustomTitledRoundedTextFormWidget(
                          controller: registerBloc.nationIdController,
                          hintText: LocaleKeys.enterNationalId.tr(),
                          title: LocaleKeys.nationalId.tr(),
                          keyboardType: TextInputType.number,
                          focusNode: registerBloc.nationIdFocus,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (phone) {
                            registerBloc.nationIdFocus.unfocus();
                          },
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return LocaleKeys.validationInsertData.tr();
                            } else if (value!.length > 14) {
                              return LocaleKeys.nationalIdErrorMessage.tr();
                            } else if (state.errors != null && state.errors?.nationalId != null) {
                              return state.errors?.nationalId?.first;
                            } else {
                              return null;
                            }
                          },
                        ),*/
                        if(registerBloc.showNationalIdentity())RegisterNationalIdImage(
                          addSingleImage: (image) {
                            registerBloc.add(RegisterAddNationalIdImage(File(image.path!)));
                          },
                          nationalIdImageFile: state.nationalIdImageFile,
                          removeImage: () {
                            registerBloc.add(const RegisterRemoveNationalIdImage());
                          },
                        ),
                        ((state.nationalIdErrorMessage != null && state.nationalIdErrorMessage != "")
                            ? Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Text(
                                  state.nationalIdErrorMessage!,
                                  style: errorTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Container()),
                        TermsAndConditions(
                          isSelected: state.isTermsSelected,
                          onChanged: (isSelected) {
                            registerBloc.add(SelectUnSelectTerms(isSelected));
                          },
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.only(start: 15, top: 25),
                          child: Center(
                            child: Text(
                              (state.generalErrorMessage != null) ? state.generalErrorMessage! : "",
                              style: errorTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        RegisterSignUpWidget(
                          isLoading: state.isLoading,
                          hideError: () {
                            registerBloc.add(const HideError());
                          },
                          register: () {
                            registerBloc.add(const RegisterUser());
                          },
                          validateImages: () {
                            registerBloc.add(const ValidateImages());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

bool isStartByCountryCode(String value) {
  return value.length == 13 && value.startsWith("+2");
}

bool isNotStartWithCountryCode(String value) {
  return value.length == 11 && !value.startsWith("+2");
}
