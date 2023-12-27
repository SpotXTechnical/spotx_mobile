import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/statistics/screens/statistics_contacts/utils.dart';
import 'package:owner/utils/style/theme.dart';

class StatisticsContactsUserGuestHeader extends StatelessWidget {
  const StatisticsContactsUserGuestHeader(
      {Key? key, required this.selectedUsersType, required this.usersButtonAction, required this.guestsButtonAction})
      : super(key: key);
  final SelectedUsersType selectedUsersType;
  final Function usersButtonAction;
  final Function guestsButtonAction;
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
                      color: (selectedUsersType == SelectedUsersType.user)
                          ? Theme.of(context).primaryColorLight
                          : Theme.of(context).unselectedWidgetColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(top: 12, bottom: 12),
                    child: Text(
                      LocaleKeys.users.tr(),
                      style: circularBook(color: kWhite, fontSize: 15),
                    ),
                  ),
                ),
                onTap: () {
                  if (selectedUsersType == SelectedUsersType.guest) {
                    usersButtonAction.call();
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
                      color: (selectedUsersType == SelectedUsersType.guest)
                          ? Theme.of(context).primaryColorLight
                          : Theme.of(context).unselectedWidgetColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(top: 12, bottom: 12),
                    child: Text(
                      LocaleKeys.guests.tr(),
                      style: circularBook(color: kWhite, fontSize: 15),
                    ),
                  ),
                ),
                onTap: () {
                  if (selectedUsersType == SelectedUsersType.user) {
                    guestsButtonAction.call();
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