import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/auth/login/bloc/login_bloc.dart';
import 'package:spotx/utils/style/theme.dart';

class DoNotHaveAccountWidget extends StatelessWidget {
  const DoNotHaveAccountWidget({
    Key? key,
    required this.loginBloc,
  }) : super(key: key);

  final LoginBloc loginBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsetsDirectional.only(start: 15, top: 0, bottom: 30),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.doNotHaveAccount.tr(),
                style: circularMedium(color: kWhite, fontSize: 12),
              ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                child: Text(
                  LocaleKeys.signUp.tr(),
                  style: circularBold(color: pacificBlue, fontSize: 16),
                ),
                onTap: () {
                  loginBloc.handleNavigation();
                },
              )
            ],
          ),
        )
    );
  }
}