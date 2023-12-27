import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';

class EditScreensActions extends StatelessWidget {
  const EditScreensActions({Key? key, required this.nextAction, required this.updateAction}) : super(key: key);
  final Function nextAction;
  final Function updateAction;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: AppButtonGradient(
            title: LocaleKeys.next.tr(),
            height: 55,
            borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
            textWidget: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              child: Center(
                  child: Text(LocaleKeys.next.tr(),
                      style: circularMedium(color: kWhite, fontSize: 17))),
            ),
            action: () async {
              nextAction();
            },
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          flex: 1,
          child: AppButtonGradient(
            title: LocaleKeys.submit.tr(),
            height: 55,
            borderRadius: const BorderRadiusDirectional.all(Radius.circular(28)),
            textWidget: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              child: Center(
                  child: Text(LocaleKeys.update.tr(),
                      style: circularMedium(color: kWhite, fontSize: 17))),
            ),
            action: () async {
              updateAction();
            },
          ),
        ),
      ],
    );
  }
}