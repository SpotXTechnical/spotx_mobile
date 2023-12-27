import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/auth/auth_repository.dart';
import 'package:spotx/data/remote/auth/models/get_cities_response_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/auth/register/bloc/register_bloc.dart';
import 'package:spotx/presentation/auth/register/bloc/register_event.dart';
import 'package:spotx/presentation/auth/register/screens/select_city/select_city_screen.dart';
import 'package:spotx/presentation/auth/register/widgets/register_input_widget.dart';
import 'package:spotx/presentation/auth/register/widgets/terms_conditions_checkbox_widget.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/utils.dart';
import 'package:spotx/utils/widgets/app_button.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/header.dart';

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
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: CustomScaffold(
                resizeToAvoidBottomInset : true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar:PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: Header(
                    title: LocaleKeys.signUp.tr(),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 10),
                    child: Form(
                      key: RegisterBloc.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RegisterInputWidget(
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
                            autoFocus: true,
                          ),
                          RegisterInputWidget(
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
                          RegisterInputWidget(
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
                              } else if (value!.length != 11) {
                                return LocaleKeys.phoneValidationMessage.tr();
                              } else if (state.errors != null && state.errors?.phone != null) {
                                return state.errors?.phone?.first;
                              } else {
                                return null;
                              }
                            },
                          ),
                          RegisterInputWidget(
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
                          RegisterInputWidget(
                            controller: registerBloc.confirmPasswordController,
                            hintText: LocaleKeys.enterYourPassword.tr(),
                            title: LocaleKeys.password.tr(),
                            obscureText: true,
                            hidePassword: true,
                            keyboardType: TextInputType.visiblePassword,
                            focusNode: registerBloc.confirmPasswordFocus,
                            textInputAction: TextInputAction.done,
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
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsetsDirectional.only(top: 20),
                            child: AppButton(
                              title: LocaleKeys.register.tr(),
                              height: 55,
                              borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
                              isLoading: state.isLoading,
                              textWidget: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(28)),
                                ),
                                child: Center(
                                    child: Text(
                                  LocaleKeys.register.tr(),
                                  style: circularMedium(color: kWhite, fontSize: 17),
                                )),
                              ),
                              action: () async {
                                registerBloc.add(const HideError());
                                await Future.delayed(const Duration(milliseconds: 100));
                                var isFormKeyValid = RegisterBloc.formKey.currentState?.validate();
                                if(state.isTermsSelected == false) {
                                  showErrorMessage(message: LocaleKeys.termsAndConditionsMessage.tr());
                                }
                                if ((isFormKeyValid ?? false) && state.isTermsSelected) {
                                  FocusScope.of(context).unfocus();
                                  registerBloc.add(const RegisterUser());
                                } else {
                                  registerBloc.add(const HideError());
                                }
                              },
                            ),
                          ),
                        ],
                      ),
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

  void handleNavigationToSelectCityScreen(RegisterBloc registerBloc, BuildContext context) async {
    var result = await navigationKey.currentState?.pushNamed(SelectCityScreen.tag);
    registerBloc.add(SetCity(result as City));
    registerBloc.phoneFocus.unfocus();
    FocusScope.of(context).requestFocus(registerBloc.passwordFocus);
  }
}