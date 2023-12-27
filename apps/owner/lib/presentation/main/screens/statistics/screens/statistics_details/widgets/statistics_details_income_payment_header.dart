import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/utils.dart';
import 'package:owner/utils/style/theme.dart';

class StatisticsDetailsIncomePaymentHeader extends StatelessWidget {
  const StatisticsDetailsIncomePaymentHeader(
      {Key? key, required this.selectedFinancialType, required this.paymentButtonAction, required this.inComeButtonAction})
      : super(key: key);
  final SelectedFinancialType selectedFinancialType;
  final Function paymentButtonAction;
  final Function inComeButtonAction;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 21, bottom: 21),
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: (selectedFinancialType == SelectedFinancialType.payment)
                          ? Theme.of(context).primaryColorLight
                          : Theme.of(context).unselectedWidgetColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(top: 12, bottom: 12),
                    child: Text(
                      LocaleKeys.payment.tr(),
                      style: circularBook(color: kWhite, fontSize: 15),
                    ),
                  ),
                ),
                onTap: () {
                  if (selectedFinancialType == SelectedFinancialType.income) {
                    paymentButtonAction.call();
                  }
                },
              ),
              flex: 1,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: (selectedFinancialType == SelectedFinancialType.income)
                          ? Theme.of(context).primaryColorLight
                          : Theme.of(context).unselectedWidgetColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(top: 12, bottom: 12),
                    child: Text(
                      LocaleKeys.income.tr(),
                      style: circularBook(color: kWhite, fontSize: 15),
                    ),
                  ),
                ),
                onTap: () {
                  if (selectedFinancialType == SelectedFinancialType.payment) {
                    inComeButtonAction.call();
                  }
                },
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}