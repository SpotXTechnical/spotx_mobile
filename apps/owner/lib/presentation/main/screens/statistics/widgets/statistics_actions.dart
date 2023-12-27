import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/statistics/screens/send_notification/send_notification_screen.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_contacts/statistics_contacts_screen.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_details/statistics_details_screen.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';

class StatisticsAction extends StatelessWidget {
  const StatisticsAction(this.getTotalIncomeAction, {Key? key}) : super(key: key);
  final Function getTotalIncomeAction;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildActionBox(statisticalIconPath, LocaleKeys.statisticsDetails.tr(), () async {
          await navigationKey.currentState?.pushNamed(StatisticsDetailsScreen.tag);
          getTotalIncomeAction();
        }, context),
        buildActionBox(contactsIconPath, LocaleKeys.contacts.tr(), () {
          navigationKey.currentState?.pushNamed(StatisticsContactsScreen.tag);
        }, context),
        buildActionBox(statisticsNotificationIconPath, LocaleKeys.sendNotification.tr(), () {
          navigationKey.currentState?.pushNamed(SendNotificationScreen.tag);
        }, context)
      ],
    );
  }

  Widget buildActionBox(String iconPath, String text, Function action, BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(top: 17),
        decoration: BoxDecoration(color: Theme.of(context).backgroundColor, borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(iconPath, color: kWhite),
                  const SizedBox(width: 20),
                  Text(
                    text,
                    style: poppinsMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                  )
                ],
              ),
              Image.asset(arrowRightIconPath, color: kWhite)
            ],
          ),
        ),
      ),
      onTap: () {
        action.call();
      },
    );
  }
}