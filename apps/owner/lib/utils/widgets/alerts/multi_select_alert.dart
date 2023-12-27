import 'package:easy_localization/src/public_ext.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/alerts/base_alert.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';

class MultiSelectAlert extends StatelessWidget {
  const MultiSelectAlert({
    Key? key,
    this.title = '',
    this.body = '',
    required this.actions,
  }) : super(key: key);

  final String title;
  final String body;
  final Map<String, VoidCallback> actions;

  @override
  Widget build(BuildContext context) {
    return BaseAlert(
      title: title,
      body: body,
      buttonsWidget: Column(children: createButtonsList(context, actions)),
    );
  }

  List<Widget> createButtonsList(BuildContext context, Map<String, VoidCallback> actions) {
    List<Widget> list = List.empty(growable: true);
    actions.forEach((key, value) {
      list.add(AppButtonGradient(
        textWidget: Text(key, style: circularMedium(color: kWhite, fontSize: 17)),
        title: key,
        color: kWhite,
        action: () {
          context.navigator.pop(true);
          value.call();
        },
      ));
    });
    list.add(AppButtonGradient(
      textWidget: Text(LocaleKeys.cancel.tr(), style: circularMedium(color: kWhite, fontSize: 17)),
      title: LocaleKeys.cancel.tr(),
      color: kWhite,
      action: () {
        context.navigator.pop(false);
      },
    ));
    return list;
  }
}