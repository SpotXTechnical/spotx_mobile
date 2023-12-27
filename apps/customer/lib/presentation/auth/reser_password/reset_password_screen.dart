import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/data/remote/auth/auth_repository.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/auth/register/widgets/register_input_widget.dart';
import 'package:spotx/presentation/auth/reser_password/bloc/reset_password_bloc.dart';
import 'package:spotx/presentation/auth/reser_password/bloc/reset_password_event.dart';
import 'package:spotx/presentation/auth/reser_password/bloc/reset_password_state.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/app_button.dart';
import 'package:spotx/utils/widgets/custom_safe_area.dart';
import 'package:spotx/utils/widgets/custom_scaffold.dart';
import 'package:spotx/utils/widgets/header.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);
  static const tag = "ResetPasswordScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordBloc>(
      create: (ctx) => ResetPasswordBloc(authRepository: AuthRepository()),
      child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        builder: (context, state) {
          ResetPasswordBloc resetPasswordBloc = BlocProvider.of(context);
          return CustomSafeArea(
            child: CustomScaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: SingleChildScrollView(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.resetPassword.tr(),
                              style: circularBold(color: kWhite, fontSize: 34),
                            ),
                            RegisterInputWidget(
                              controller: resetPasswordBloc.passwordController,
                              hintText: LocaleKeys.enterYourPassword.tr(),
                              title: LocaleKeys.newPassword.tr(),
                              focusNode: resetPasswordBloc.passwordFocus,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.visiblePassword,
                              hidePassword: true,
                              obscureText: true,
                              onFieldSubmitted: (password) {
                                resetPasswordBloc.passwordFocus.unfocus();
                                FocusScope.of(context).requestFocus(resetPasswordBloc.repeatPasswordFocus);
                              },
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return LocaleKeys.validationInsertData.tr();
                                } else if (state.generalErrorMessage != null) {
                                  return state.generalErrorMessage;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            RegisterInputWidget(
                              controller: resetPasswordBloc.repeatPasswordController,
                              hintText: LocaleKeys.enterYourPassword.tr(),
                              title: LocaleKeys.retypeYourPassword.tr(),
                              obscureText: true,
                              hidePassword: true,
                              keyboardType: TextInputType.visiblePassword,
                              focusNode: resetPasswordBloc.repeatPasswordFocus,
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return LocaleKeys.validationInsertData.tr();
                                } else if (resetPasswordBloc.passwordController.text.isNotEmpty &&
                                    resetPasswordBloc.passwordController.text != resetPasswordBloc.repeatPasswordController.text) {
                                  return LocaleKeys.passwordMismatchMessage.tr();
                                } else {
                                  return null;
                                }
                              },
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsetsDirectional.only(top: 20),
                              child: AppButton(
                                title: LocaleKeys.submit.tr(),
                                height: 55,
                                borderRadius: BorderRadiusDirectional.all(Radius.circular(28)),
                                isLoading: state.isLoading,
                                textWidget: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(28)),
                                  ),
                                  child: Center(child: Text(LocaleKeys.submit.tr())),
                                ),
                                action: () async {
                                  resetPasswordBloc.add(const ResetPasswordHideError());
                                  await Future.delayed(const Duration(milliseconds: 100));
                                  if (ResetPasswordBloc.formKey.currentState?.validate() ?? false) {
                                    FocusScope.of(context).unfocus();
                                    resetPasswordBloc.add(const ResetPasswordUser());
                                  } else {
                                    resetPasswordBloc.add(const ResetPasswordHideError());
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
              ),
            ),
          );
        },
      ),
    );
  }
}