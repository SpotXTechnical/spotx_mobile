import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/style/theme.dart';

import '../bloc/unit_details_state.dart';

class UnitDetailsContentChoices extends StatelessWidget {
  const UnitDetailsContentChoices({
    Key? key,
    required this.selectedContentType,
    required this.typeAction,
  }) : super(key: key);
  final SelectedContentType selectedContentType;
  final Function typeAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 21, bottom: 21, start: 21, end: 21),
      decoration:
          BoxDecoration(color: Theme.of(context).backgroundColor, borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
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
                    typeAction.call();
                  }
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
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
                    typeAction.call();
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