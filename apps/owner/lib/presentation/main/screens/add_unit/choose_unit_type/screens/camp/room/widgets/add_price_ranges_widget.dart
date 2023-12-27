import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';

class AddPriceRangesWidget extends StatelessWidget {
  const AddPriceRangesWidget({Key? key, required this.addPriceRangesAction}) : super(key: key);
  final Function addPriceRangesAction;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: DottedBorder(
        color: Theme.of(context).disabledColor,
        strokeWidth: 1,
        dashPattern: const [8, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(addIconPath, color: kWhite),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  LocaleKeys.add.tr(),
                  style: circularBook(color: kWhite, fontSize: 17),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        addPriceRangesAction.call();
      },
    );
  }
}