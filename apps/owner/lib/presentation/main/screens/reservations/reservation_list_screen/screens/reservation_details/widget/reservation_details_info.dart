import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/reservation_details/widget/price_widget.dart';
import 'package:owner/utils/date_utils/date_formats.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';

class ReservationDetailsInfoWidget extends StatelessWidget {
  const ReservationDetailsInfoWidget({
    Key? key,
    required this.reservation,
  }) : super(key: key);

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final isDiscount =  reservation.discount != 0;

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
                Expanded(
                  child: GestureDetector(
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
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 4,
                  child: Wrap(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.reservationDate.tr(),
                            style: circularMedium(color: kWhite, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            children: [
                              Text(
                                "${LocaleKeys.from.tr()} ${getDateFormat(reservation.from ?? defaultDateTime, context)}",
                                style: circularBook(color: Theme.of(context).hintColor, fontSize: 13),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${LocaleKeys.to.tr()} ${getDateFormat(reservation.to ?? defaultDateTime, context)}",
                                style: circularBook(color: Theme.of(context).hintColor, fontSize: 13),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    "${reservation.days} ${LocaleKeys.nights.tr()}",
                    style: circularMedium(color: kWhite, fontSize: 14),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(top: 20, bottom: 20),
              height: 1,
              color: Theme.of(context).disabledColor,
            ),
            Row(
              crossAxisAlignment:  isDiscount ?  CrossAxisAlignment.start:  CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: Theme.of(context).dialogBackgroundColor),
                      color: Colors.transparent),
                  alignment: Alignment.center,
                  width: 42,
                  height: 42,
                  child: Image.asset(priceBorderIconPath, color: kWhite),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      if (isDiscount)  PriceWidget(
                        price: reservation.totalPrice.toString(),
                        title: LocaleKeys.price.tr(),
                        titleStyle: circularBook(
                          color: Theme.of(context).hintColor,
                          fontSize: 13,
                        ),
                        valueStyle: circularBook(
                          color: Theme.of(context).hintColor,
                          fontSize: 13,
                        ),
                      ),
                      if (isDiscount)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: PriceWidget(
                            price: "-${reservation.discount}",
                            title:
                            '${LocaleKeys.companyDiscount.tr()} ${(((reservation.discount ?? 0) / (reservation.totalPrice ?? 0)) * 100).toInt()}%',
                            titleStyle: circularBook(
                              color: Theme.of(context).hintColor,
                              fontSize: 13,
                            ),
                            valueStyle:
                            circularBook(
                              color: Theme.of(context).hintColor,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      if (isDiscount) Container(
                        margin: const EdgeInsetsDirectional.only(top: 5, bottom: 9),
                        height: 1,
                        color: Theme.of(context).disabledColor,
                      ),
                      PriceWidget(
                        price: reservation.subTotal.toString(),
                        title: LocaleKeys.totalCost.tr(),
                        titleStyle: circularMedium(color: kWhite, fontSize: 15),
                        valueStyle: circularMedium(color: kWhite, fontSize: 15),
                      ),
                    ],
                  ),
                ),
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