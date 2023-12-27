import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/app_button.dart';
import '../../../../../../../utils/navigation/navigation_helper.dart';
import '../../../../../../auth/login/login_screen.dart';

class ReservationAuthorizationWidget extends StatelessWidget {
  const ReservationAuthorizationWidget({
    Key? key,
    required this.getReservationData,
  }) : super(key: key);
  final Function getReservationData;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25, left: 22, right: 22),
          child: Text(
            LocaleKeys.unAuthorized.tr(),
            style: circularMedium(color: cadetGrey, fontSize: 17),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 22, right: 22),
          child: Text(
            LocaleKeys.itIsRequiredToLoginToPerformTheNextAction.tr(),
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
                  LocaleKeys.login.tr(),
                  style: circularMedium(color: kWhite, fontSize: 17),
                ),
                action: () async {
                  var result = await navigationKey.currentState?.pushNamed(LoginScreen.tag, arguments: true);
                  if (result != null && result as bool) {
                    getReservationData();
                  }
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}