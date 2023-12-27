import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/style/theme.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        LocaleKeys.signUp.tr(),
        style: circularBold800(color: kWhite, fontSize: 34),
      ),
    );
  }
}