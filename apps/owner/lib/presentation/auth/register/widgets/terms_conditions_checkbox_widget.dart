import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/const.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/utils.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    Key? key,
    required this.isSelected,
    required this.onChanged
  }) : super(key: key);
  final bool isSelected;
  final Function(bool) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 16, end: 16, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (val) {
              if(val != null) {
                onChanged.call(val);
              }
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                children: [
                  TextSpan(text: '${LocaleKeys.agreeTerms.tr()} '),
                  TextSpan(
                      text: LocaleKeys.terms.tr(),
                      style: const TextStyle(color: blueDiamond),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchURLInAppBrowser(termsConditions);
                        }),
                  TextSpan(text: ' ${LocaleKeys.toContinue.tr()}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );;
  }
}

