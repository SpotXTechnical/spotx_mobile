import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/reservations/reservation_list_screen/screens/reservation_details/widget/price_widget.dart';
import 'package:owner/utils/date_utils/date_formats.dart';
import 'package:owner/utils/style/theme.dart';

class ReservationDetailsInfoDialogWidget extends StatelessWidget {
  const ReservationDetailsInfoDialogWidget({
    Key? key,
    required this.reservation,
  }) : super(key: key);

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final isDiscount = reservation.discount != 0;

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
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 10),
              child: Text(
                LocaleKeys.reservationDate.tr(),
                style: circularMedium(color: kWhite, fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 10
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          LocaleKeys.from.tr(),
                          style: circularBook(
                              color: Theme.of(context).hintColor, fontSize: 13),
                        ),
                        const SizedBox(height: 5),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          LocaleKeys.to.tr(),
                          style: circularBook(
                              color: Theme.of(context).hintColor, fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getDateFormat(
                            reservation.from ?? defaultDateTime, context),
                        style: circularBook(
                            color: Theme.of(context).hintColor, fontSize: 13),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        getDateFormat(reservation.to?.add(const Duration(days: 1)) ?? defaultDateTime, context),
                        style: circularBook(
                            color: Theme.of(context).hintColor, fontSize: 13),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    "${reservation.days} ${LocaleKeys.nights.tr()}",
                    style: circularMedium(color: kWhite, fontSize: 14),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsetsDirectional.only(top: 10, bottom: 20),
              height: 1,
              color: Theme.of(context).disabledColor,
            ),
            Row(
              crossAxisAlignment: isDiscount
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      if (isDiscount)
                        PriceWidget(
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
                            valueStyle: circularBook(
                              color: Theme.of(context).hintColor,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      if (isDiscount)
                        Container(
                          margin: const EdgeInsetsDirectional.only(
                              top: 5, bottom: 9),
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