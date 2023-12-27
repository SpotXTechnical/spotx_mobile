import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/bloc/unit_details_state.dart';
import 'package:owner/utils/style/theme.dart';

class UnitDetailsContentChoices extends StatelessWidget {
  const UnitDetailsContentChoices(
      {Key? key,
      required this.selectedContentType,
      required this.calenderButtonAction,
      required this.overViewButtonAction,
      required this.reviewButtonAction})
      : super(key: key);
  final SelectedContentType selectedContentType;
  final Function overViewButtonAction;
  final Function calenderButtonAction;
  final Function reviewButtonAction;

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
                      color: (selectedContentType == SelectedContentType.calender)
                          ? Theme.of(context).primaryColorLight
                          : Theme.of(context).unselectedWidgetColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(top: 12, bottom: 12),
                    child: Text(
                      LocaleKeys.calender.tr(),
                      style: circularBook(color: kWhite, fontSize: 15),
                    ),
                  ),
                ),
                onTap: () {
                  if (selectedContentType != SelectedContentType.calender) {
                    calenderButtonAction.call();
                  }
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: (selectedContentType == SelectedContentType.overView)
                          ? Theme.of(context).primaryColorLight
                          : Theme.of(context).unselectedWidgetColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(top: 12, bottom: 12),
                    child: Text(
                      LocaleKeys.overview.tr(),
                      style: circularBook(color: kWhite, fontSize: 15),
                    ),
                  ),
                ),
                onTap: () {
                  if (selectedContentType != SelectedContentType.overView) {
                    overViewButtonAction.call();
                  }
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: (selectedContentType == SelectedContentType.review)
                          ? Theme.of(context).primaryColorLight
                          : Theme.of(context).unselectedWidgetColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(top: 12, bottom: 12),
                    child: Text(
                      LocaleKeys.review.tr(),
                      style: circularBook(color: kWhite, fontSize: 15),
                    ),
                  ),
                ),
                onTap: () {
                  if (selectedContentType != SelectedContentType.review) {
                    reviewButtonAction.call();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}