import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/statistics/model/income_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/style/theme.dart';

class StatisticsDetailsIncomeCard extends StatelessWidget {
  const StatisticsDetailsIncomeCard({
    Key? key,
    required this.incomeEntity,
  }) : super(key: key);
  final IncomeEntity incomeEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(color: Theme.of(context).disabledColor, width: 1)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMd(context.locale.languageCode).format(DateTime.parse(incomeEntity.to!)),
                  style: poppinsRegular(color: Theme.of(context).hintColor, fontSize: 12),
                ),
                Text(
                  incomeEntity.unit!.title! + "," + incomeEntity.unit!.regionId!,
                  style: poppinsMedium(color: kWhite, fontSize: 13),
                )
              ],
            ),
            Row(children: [
              Text(
                incomeEntity.totalPrice.toString() + " " + LocaleKeys.le.tr(),
                style: circularMedium(color: kWhite, fontSize: 14),
              ),
            ])
          ],
        ),
      ),
    );
  }
}