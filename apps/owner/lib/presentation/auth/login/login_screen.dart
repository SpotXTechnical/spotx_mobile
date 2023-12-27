import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/data/remote/auth/auth_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/auth/login/bloc/login_bloc.dart';
import 'package:owner/presentation/auth/login/bloc/login_event.dart';
import 'package:owner/presentation/auth/login/bloc/login_state.dart';
import 'package:owner/presentation/auth/login/widget/do_not_have_account_widget.dart';
import 'package:owner/presentation/auth/login/widget/login_deocation_widget.dart';
import 'package:owner/presentation/auth/login/widget/welcome_section_widget.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/CustomTextFormField.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';
import 'package:owner/utils/widgets/custom_safe_area.dart';
import 'package:owner/utils/widgets/custom_scaffold.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const tag = "LoginWidget";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (ctx) => LoginBloc(authRepository: AuthRepository()),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          LoginBloc loginBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: SafeArea(
                maintainBottomViewPadding: true,
                child: Form(
                  key: LoginBloc.formKey,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: const LoginDecorationWidget(),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 2.8,
                        alignment: Alignment.topRight,
                        child: Image.asset(loginImagePath),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Container()),
                          const WelcomeSectionWidget(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(32)),
                              color: Theme.of(context).primaryColorDark.withAlpha(200),
                            ),
                            margin: const EdgeInsetsDirectional.only(start: 15, end: 15, top: 42, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsetsDirectional.only(top: 35.0, end: 35.0, start: 35.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys.yourPhone.tr(),
                                        style: circularMedium(color: kWhite, fontSize: 16),
                                      ),
                                      CustomTextFormField(
                                        hidePassword: false,
                                        controller: loginBloc.phoneNumberController,
                                        keyboardType: TextInputType.phone,
                                        hintText: LocaleKeys.enterYourPhoneNumber.tr(),
                                        focusNode: loginBloc.phoneFocus,
                                        textInputAction: TextInputAction.next,
                                        hintStyle: TextStyle(color: kWhite, fontSize: 13),
                                        onFieldSubmitted: (email) {
                                          loginBloc.phoneFocus.unfocus();
                                          FocusScope.of(context).requestFocus(loginBloc.passwordFocus);
                                        },
                                        validator: (value) {
                                          if (value?.isEmpty ?? true) {
                                            return LocaleKeys.validationInsertData.tr();
                                          } else if (state.errors != null && state.errors?.identifier != null) {
                                            return state.errors?.identifier?.first;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(top: 19.0, end: 35.0, start: 35.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(LocaleKeys.password.tr(), style: circularMedium(color: kWhite, fontSize: 16)),
                                      CustomTextFormField(
                                          hidePassword: true,
                                          controller: loginBloc.passwordController,
                                          hintText: LocaleKeys.passwordPlaceHolder.tr(),
                                          keyboardType: TextInputType.visiblePassword,
                                          focusNode: loginBloc.passwordFocus,
                                          textInputAction: TextInputAction.done,
                                          obscureText: true,
                                          hintStyle: TextStyle(color: kWhite, fontSize: 13),
                                          validator: (value) {
                                            if (value?.isEmpty ?? true) {
                                              return LocaleKeys.validationInsertData.tr();
                                            } else if (state.errors != null && state.errors?.password != null) {
                                              return state.errors?.password?.first;
                                            } else {
                                              return null;
                                            }
                                          }),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(start: 35.0, top: 27),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Todo('add forget password flow')
                                      Expanded(
                                        flex: 1,
                                        child: /*TextButton(
                                          style: TextButton.styleFrom(padding: EdgeInsets.zero, alignment: AlignmentDirectional.centerStart),
                                          onPressed: () {},
                                          child: Text(
                                            LocaleKeys.forgotPassword.tr(),
                                            style: circularMedium(color: Theme.of(context).canvasColor, fontSize: 12),
                                          ),
                                        ),*/Container()
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: AppButtonGradient(
                                          title: LocaleKeys.login.tr(),
                                          height: 55,
                                          isLoading: state.isLoading,
                                          borderRadius:  const BorderRadiusDirectional.only(
                                            topStart: Radius.circular(28),
                                            bottomEnd: Radius.circular(28),
                                            bottomStart: Radius.circular(28),
                                          ),
                                          textWidget: SizedBox(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: Center(
                                                child: Text(LocaleKeys.login.tr(),
                                                    style: circularMedium(color: kWhite, fontSize: 17))),
                                          ),
                                          action: () async {
                                            loginBloc.add(const HideError());
                                            await Future.delayed(const Duration(milliseconds: 100));
                                            if (LoginBloc.formKey.currentState?.validate() ?? false) {
                                              FocusScope.of(context).unfocus();
                                              loginBloc.add(const LoginUser());
                                            } else {
                                              loginBloc.add(const HideError());
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(start: 15),
                            child: Center(
                              child: Text(
                                state.generalErrorMessage != null ? state.generalErrorMessage! : "",
                                style: errorTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(height: 200,),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          DoNotHaveAccountWidget(),
                        ],
                      ),
                    ],
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