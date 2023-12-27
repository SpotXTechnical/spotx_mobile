import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/statistics/model/total_icomes_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';

class StatisticsInfo extends StatelessWidget {
  const StatisticsInfo(
      {Key? key, this.margin = const EdgeInsetsDirectional.only(start: 0, end: 0), required this.totalIncomesEntity})
      : super(key: key);
  final EdgeInsetsDirectional margin;
  final TotalIncomesEntity totalIncomesEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColorLight,
            Theme.of(context).highlightColor,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          borderRadius: const BorderRadiusDirectional.all(Radius.circular(8))
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(totalIncomeIconPath),
                Container(
                  margin: const EdgeInsetsDirectional.only(start: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.totalIncome.tr(),
                        style: circularBook(color: kWhite, fontSize: 12),
                      ),
                      Text(
                        "${totalIncomesEntity.totalIncomes ?? 0} ${LocaleKeys.le.tr()}",
                        style: circularBold700(color: kWhite, fontSize: 19),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: Row(
                children: createInfoBoxes(
                    totalIncomesEntity.reservationCount ?? 0, totalIncomesEntity.totalPayments ?? 0, totalIncomesEntity.revenue?.toStringAsFixed(0)??'0', context),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> createInfoBoxes(int booking, int fees, String revenue, BuildContext context) {
    final boxesMap = {LocaleKeys.booking.tr(): booking, LocaleKeys.fees.tr(): fees, LocaleKeys.revenue.tr(): revenue};
    List<Widget> widgets = List.empty(growable: true);
    boxesMap.forEach((key, value) {
      widgets.add(Expanded(
        flex: 1,
        child: Container(
          margin:
              EdgeInsetsDirectional.only(end: (key == LocaleKeys.booking.tr() || key == LocaleKeys.fees.tr()) ? 10 : 0),
          decoration: BoxDecoration(
              color: Theme.of(context).indicatorColor, borderRadius: const BorderRadiusDirectional.all(Radius.circular(5.5))),
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
      ));
    });

    return widgets;
  }
}