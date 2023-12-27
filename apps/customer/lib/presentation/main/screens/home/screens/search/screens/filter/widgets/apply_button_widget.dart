import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/widgets/app_button.dart';

import '../../../../../../../../../utils/style/theme.dart';

class ApplyButtonWidget extends StatelessWidget {
  const ApplyButtonWidget({
    Key? key,
    required this.addApplyEvent,
  }) : super(key: key);

  final Function addApplyEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsetsDirectional.only(top: 27, bottom: 35, start: 23, end: 23),
      child: AppButton(
        title: LocaleKeys.login.tr(),
        height: 55,
        borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
        textWidget: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(28)),
          ),
          child: Center(child: Text(LocaleKeys.apply.tr(), style: circularMedium(color: kWhite, fontSize: 17))),
        ),
        action: () async {
          addApplyEvent.call();
        },
      ),
    );
  }
}