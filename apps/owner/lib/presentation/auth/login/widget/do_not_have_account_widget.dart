import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/auth/register/register_screen.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';

class DoNotHaveAccountWidget extends StatelessWidget {
  const DoNotHaveAccountWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.doNotHaveAccount.tr(),
                    style: circularMedium(color: kWhite, fontSize: 12),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    LocaleKeys.signUp.tr(),
                    style: circularBold900(color: kWhite, fontSize: 12),
                  )
                ],
              ),
            )),
        onTap: () {
          navigationKey.currentState?.pushNamed(RegisterScreen.tag);
        });
  }
}