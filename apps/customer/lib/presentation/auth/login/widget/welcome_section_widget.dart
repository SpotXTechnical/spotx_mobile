import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/style/theme.dart';

class WelcomeSectionWidget extends StatelessWidget {
  const WelcomeSectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.welcomeBack.tr(),
            style: circularMedium(color: kWhite, fontSize: 35),
          ),
          Text(
            LocaleKeys.signInToYourAccount.tr(),
            style: circularMedium(color: kWhite, fontSize: 17),
          ),
        ],
      ),
    );
  }
}