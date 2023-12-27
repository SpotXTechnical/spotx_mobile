import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:owner/utils/images.dart';

import '../../../../../utils/const.dart';
import '../../../../../utils/navigation/navigation_helper.dart';
import '../../../../../utils/style/theme.dart';
import '../../../main_screen.dart';

class LangRow extends StatelessWidget {
  const LangRow({Key? key, required this.index, required this.lang, required this.selectedLang}) : super(key: key);

  final int index;
  final Locale lang;
  final Locale selectedLang;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lang.languageCode == "ar" ? "العربية" : "English",
                  style: circularBook(color: Theme.of(context).hintColor, fontSize: 16),
                ),
                if (selectedLang.languageCode == lang.languageCode)
                  Image.asset(checkMarkIconPath, color: kWhite)
              ],
            ),
            if (localeList.length - 1 != index)
              Container(
                margin: const EdgeInsetsDirectional.only(top: 16),
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Theme.of(context).unselectedWidgetColor,
              )
          ],
        ),
      ),
      onTap: () {
        if (selectedLang != lang) {
          context.setLocale(lang);
          Navigator.of(context).pop();
          navigationKey.currentState?.pushNamedAndRemoveUntil(MainScreen.tag, (_) => false);
        } else {
          Navigator.of(context).pop();
        }
      },
    );
  }
}