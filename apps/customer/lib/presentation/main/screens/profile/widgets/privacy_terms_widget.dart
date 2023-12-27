import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/const.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/utils.dart';
import 'package:spotx/utils/widgets/locale_icon_direction.dart';

class PrivacyTermsWidget extends StatelessWidget {
  const PrivacyTermsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 15, start: 10, end: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsetsDirectional.only(bottom: 8),
            child: Text(
              LocaleKeys.privacyAndTerms.tr(),
              style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 15),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(12))),
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    launchURLInAppBrowser(privacyPolicy);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.privacyPolicy.tr(),
                          style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                        ),
                        const LocaleIconDirection(icon: arrowIconPath)
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 10, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Theme.of(context).unselectedWidgetColor,
                ),
                InkWell(
                  onTap: () {
                    launchURLInAppBrowser(termsConditions);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.termsAndConditions.tr(),
                          style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                        ),
                        const LocaleIconDirection(icon: arrowIconPath)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}