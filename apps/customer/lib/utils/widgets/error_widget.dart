import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/app_button.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    Key? key,
    required this.action,
  }) : super(key: key);
  final Function? action;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(noWifiIconPath, color: kWhite),
        Container(
          margin: const EdgeInsets.only(top: 25, left: 22, right: 22),
          child: Text(
            LocaleKeys.noInternet.tr(),
            style: circularMedium(color: cadetGrey, fontSize: 17),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 22, right: 22),
          child: Text(
            LocaleKeys.noInternetMessage.tr(),
            style: circularBook(color: Theme.of(context).splashColor, fontSize: 14),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: AppButton(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                title: LocaleKeys.tryAgain.tr(),
                textWidget: Text(
                  LocaleKeys.tryAgain.tr(),
                  style: circularMedium(color: kWhite, fontSize: 17),
                ),
                action: () {
                  action?.call();
                },
              ),
            )
          ],
        )
      ],
    );
  }
}