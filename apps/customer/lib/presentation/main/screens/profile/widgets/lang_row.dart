import 'package:flutter/material.dart';

import '../../../../../utils/const.dart';
import '../../../../../utils/images.dart';
import '../../../../../utils/style/theme.dart';

class LangRow extends StatelessWidget {
  const LangRow({
    Key? key,
    required this.index,
    required this.lang,
    required this.selectedLang,
    this.onPressed,
  }) : super(key: key);

  final int index;
  final Locale lang;
  final Locale selectedLang;
  final Function(Locale local)? onPressed;

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
                if (selectedLang.languageCode == lang.languageCode) Image.asset(checkMarkIconPath, color: kWhite)
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
        onPressed?.call(selectedLang);
      },
    );
  }
}