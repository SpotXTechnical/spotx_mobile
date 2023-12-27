import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/auth/register/bloc/register_bloc.dart';
import '../../../../utils/style/theme.dart';
import '../../../../utils/widgets/app_buttons/gradientAppButton.dart';

class RegisterSignUpWidget extends StatelessWidget {
  const RegisterSignUpWidget({
    Key? key,
    required this.isLoading,
    required this.hideError,
    required this.register,
    required this.validateImages,
  }) : super(key: key);

  final bool isLoading;
  final Function hideError;
  final Function register;
  final Function validateImages;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 20),
      child: AppButtonGradient(
        title: LocaleKeys.register.tr(),
        height: 55,
        borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
        isLoading: isLoading,
        textWidget: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(28)),
          ),
          child: Center(child: Text(LocaleKeys.register.tr(), style: circularMedium(color: kWhite, fontSize: 17))),
        ),
        action: () async {
          hideError.call();
          await Future.delayed(const Duration(milliseconds: 100));
          if (RegisterBloc.formKey.currentState?.validate() ?? false) {
            FocusScope.of(context).unfocus();
            register.call();
          } else {
            validateImages();
            hideError.call();
          }
        },
      ),
    );
  }
}