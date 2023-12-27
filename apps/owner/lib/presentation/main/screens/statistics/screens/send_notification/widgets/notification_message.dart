import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/statistics/screens/send_notification/widgets/circle_progress.dart';
import 'package:owner/utils/style/theme.dart';

class NotificationMessage extends StatelessWidget {
  const NotificationMessage({Key? key, required this.notificationCount}) : super(key: key);
  final int notificationCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 21, left: 19, right: 19),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColorLight,
            Theme.of(context).highlightColor,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          borderRadius: const BorderRadiusDirectional.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                "${LocaleKeys.notificationMessagePart1.tr()} $notificationCount ${LocaleKeys.notificationMessagePart2.tr()}",
                style: poppinsMedium(color: kWhite, fontSize: 17),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: CustomPaint(
                  foregroundPainter: CircleProgress(
                      arcColor: kWhite,
                      strokeWidth: 2.5,
                      mainColor: Theme.of(context).disabledColor,
                      radius: 25,
                      percentage: 25.0),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.ideographic,
                        children: [
                          Text("1", style: circularBold800(color: kWhite, fontSize: 24)),
                          Text("/4", style: circularBold800(color: kWhite, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> createInfoBoxes(BuildContext context) {
    final boxesMap = {LocaleKeys.booking.tr(): 23, LocaleKeys.fees.tr(): 4.75, LocaleKeys.revenue.tr(): 50.0};
    List<Widget> widgets = List.empty(growable: true);
    boxesMap.forEach((key, value) {
      widgets.add(Expanded(
        child: Container(
          margin:
              EdgeInsetsDirectional.only(end: (key == LocaleKeys.booking.tr() || key == LocaleKeys.fees.tr()) ? 10 : 0),
          decoration: BoxDecoration(
              color: Theme.of(context).indicatorColor, borderRadius: BorderRadiusDirectional.all(Radius.circular(5.5))),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                Text(
                  value.toString(),
                  style: poppinsBold(color: kWhite, fontSize: 18),
                ),
                Text(
                  key,
                  style: poppinsRegular(color: kWhite, fontSize: 14),
                )
              ],
            ),
          ),
        ),
        flex: 1,
      ));
    });

    return widgets;
  }
}