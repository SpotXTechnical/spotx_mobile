import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/CustomClipRect.dart';

import '../screens/reservation_details/reservation_details_screen.dart';

class CalenderReservationCard extends StatelessWidget {
  const CalenderReservationCard({Key? key, required this.reservation}) : super(key: key);

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomClipRect(
                      borderRadius: BorderRadius.circular(12),
                      path: reservation.unit?.mainImage?.url,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsetsDirectional.only(start: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(11.5)),
                                  color: Theme.of(context).indicatorColor),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                                child: Text(
                                  reservation.unit?.type ?? "",
                                  style: circularMedium(color: Theme.of(context).secondaryHeaderColor, fontSize: 14),
                                ),
                              )),
                          Container(
                            margin: const EdgeInsetsDirectional.only(top: 7),
                            child: Text(
                              reservation.unit!.description ?? "",
                              style: circularBook(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsetsDirectional.only(top: 9),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${reservation.days} ${LocaleKeys.nights.tr()}",
                                    style: circularMedium(color: kWhite, fontSize: 14),
                                  ),
                                ],
                              )),
                          Container(
                            margin: const EdgeInsetsDirectional.only(top: 11),
                            color: Theme.of(context).disabledColor,
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          LocaleKeys.totalCost.tr(),
                          style: circularBook(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${reservation.totalPrice} ${LocaleKeys.le.tr()}",
                          style: circularMedium(color: kWhite, fontSize: 14),
                        )
                      ],
                    ),
                    Text(
                      reservation.status == ReservationStatus.pending.name ? "Pending" : "Reserved",
                      style: circularMedium(
                          color: reservation.status == ReservationStatus.pending.name
                              ? Theme.of(context).selectedRowColor
                              : Theme.of(context).primaryColorLight,
                          fontSize: 14),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        navigationKey.currentState?.pushNamed(ReservationDetailsScreen.tag, arguments: reservation.id.toString());
      },
    );
  }
}