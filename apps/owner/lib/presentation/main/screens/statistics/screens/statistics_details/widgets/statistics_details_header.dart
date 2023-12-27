import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/statistics/model/statistics_filter.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/statistics/screens/filter/filter_screen.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';

class StatisticsDetailsHeader extends StatelessWidget {
  const StatisticsDetailsHeader({
    Key? key,
    required this.filterAction,
    this.statisticsFilter,
  }) : super(key: key);

  final Function(StatisticsFilter) filterAction;
  final StatisticsFilter? statisticsFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(backNavIconPath, color: kWhite),
              width: 44,
              height: 44,
            ),
            onTap: () {
              navigationKey.currentState?.pop();
            },
          ),
          Text(
            LocaleKeys.statisticsDetails.tr(),
            style: circularMedium(color: kWhite, fontSize: 17),
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Theme.of(context).disabledColor)),
              width: 44,
              height: 44,
              child: Image.asset(filterIconPath, color: kWhite),
            ),
            onTap: () async {
              var result = await navigationKey.currentState?.pushNamed(FilterScreen.tag, arguments: statisticsFilter);
              if (result != null) {
                filterAction(result as StatisticsFilter);
              }
            },
          ),
        ],
      ),
    );
  }
}