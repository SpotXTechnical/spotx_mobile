import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/utils.dart';

class ReservationDetailsInfoWidget extends StatelessWidget {
  const ReservationDetailsInfoWidget(
      {Key? key,
      required this.fromDate,
      required this.toDate,
      required this.daysCount,
      required this.price,
      this.checkOut,
      this.checkIn})
      : super(key: key);

  final DateTime fromDate;
  final DateTime toDate;
  final int daysCount;
  final int price;
  final String? checkIn;
  final String? checkOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 17, start: 24, end: 24),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(color: Theme.of(context).dialogBackgroundColor),
                        color: Colors.transparent),
                    alignment: Alignment.center,
                    width: 42,
                    height: 42,
                    child: Image.asset(calenderIconPath, color: kWhite),
                  ),
                  onTap: () {},
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: Wrap(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.reservationDate.tr(),
                                style: circularMedium(color: kWhite, fontSize: 15),
                              ),
                              Text(
                                "$daysCount ${LocaleKeys.nights.tr()}",
                                style: circularMedium(color: kWhite, fontSize: 14),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${LocaleKeys.from.tr()} ${getDateFormat(fromDate, context)}",
                                style: circularBook(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 13),
                              ),
                              if (checkIn != null)
                                Text(
                                  parseTime(checkIn).format(context),
                                  style: circularBook(
                                      color: Theme.of(context).hintColor,
                                      fontSize: 13),
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${LocaleKeys.to.tr()} ${getDateFormat(toDate, context)}",
                                style: circularBook(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 13),
                              ),
                              if (checkOut != null)
                                Text(
                                  parseTime(checkOut).format(context),
                                  style: circularBook(
                                      color: Theme.of(context).hintColor,
                                      fontSize: 13),
                                )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(top: 20, bottom: 20),
              height: 1,
              color: Theme.of(context).disabledColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            border: Border.all(color: Theme.of(context).dialogBackgroundColor),
                            color: Colors.transparent),
                        alignment: Alignment.center,
                        width: 42,
                        height: 42,
                        child: Image.asset(priceIconPath, color: kWhite),
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      LocaleKeys.totalCost.tr(),
                      style: circularBook(color: Theme.of(context).hintColor, fontSize: 13),
                    ),
                  ],
                ),
                Text(
                  "$price ${LocaleKeys.le.tr()}",
                  style: circularMedium(color: kWhite, fontSize: 14),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String getDateFormat(DateTime date, BuildContext context) {
    return DateFormat.MMMEd(context.locale.languageCode).format(date);
  }
}