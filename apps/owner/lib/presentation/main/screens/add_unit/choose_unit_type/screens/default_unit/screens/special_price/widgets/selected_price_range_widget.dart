import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';

class SelectedPriceRangeWidget extends StatelessWidget {
  const SelectedPriceRangeWidget({Key? key, required this.priceRange, required this.deleteAction, required this.editAction}) : super(key: key);
  final PriceRange priceRange;
  final Function deleteAction;
  final Function editAction;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(const Radius.circular(20)), color: Theme.of(context).backgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: LocaleKeys.from.tr(),
                        style: circularBook(color: Theme.of(context).splashColor, fontSize: 14),
                      ),
                      const TextSpan(
                        text: " ",
                      ),
                      TextSpan(
                        text: DateFormat.MMMEd(context.locale.languageCode).format(priceRange.startDay!),
                        style: circularBook(color: kWhite, fontSize: 14),
                      ),
                      const TextSpan(
                        text: " ",
                      ),
                      TextSpan(
                        text: LocaleKeys.to.tr(),
                        style: circularBook(color: Theme.of(context).splashColor, fontSize: 14),
                      ),
                      const TextSpan(
                        text: " ",
                      ),
                      TextSpan(
                        text: DateFormat.MMMEd(context.locale.languageCode).format(priceRange.endDay!),
                        style: circularBook(color: kWhite, fontSize: 14),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Text(
                        " ${priceRange.price} ${LocaleKeys.le.tr()}",
                        style: circularMedium(color: kWhite, fontSize: 17),
                      ),
                      Text(
                        LocaleKeys.perDayWithSlash.tr(),
                        style: circularMedium(color: Theme.of(context).splashColor, fontSize: 14),
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  child: Image.asset(editIconPath, color: kWhite),
                  onTap: () {
                    editAction.call();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: Image.asset(deleteIconPath, color: kWhite),
                  onTap: () {
                    deleteAction.call();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}