import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spotx/data/remote/reservation/model/get_reservations_response_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/pending/reservation_details_pending_screen.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/rented/reservation_details_rented_screen.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';

class ReservationCardWidget extends StatelessWidget {
  const ReservationCardWidget({Key? key, required this.reservation}) : super(key: key);

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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: reservation.unit!.mainImage != null
                          ? Image.network(
                              reservation.unit!.mainImage!.url!,
                              fit: BoxFit.cover,
                              height: 87,
                            )
                          : Image.asset(
                              sampleImagePath,
                              fit: BoxFit.cover,
                              height: 87,
                            ),
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
                            margin: const EdgeInsetsDirectional.only(top: 6.2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.totalCost.tr(),
                                  style: circularBook(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                                ),
                                Text(
                                  "${reservation.subTotal} ${LocaleKeys.le.tr()}",
                                  style: circularMedium(color: kWhite, fontSize: 14),
                                )
                              ],
                            ),
                          ),
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
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsetsDirectional.only(top: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${reservation.days} ${LocaleKeys.nights.tr()}",
                            style: circularMedium(color: kWhite, fontSize: 14),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: '(${LocaleKeys.from.tr()} ',
                                style: circularBook(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                              ),
                              TextSpan(
                                text: DateFormat.Md(context.locale.languageCode).format(reservation.from!),
                                style: circularBook(color: kWhite, fontSize: 14),
                              ),
                              TextSpan(
                                text: ' ${LocaleKeys.to.tr()} ',
                                style: circularBook(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                              ),
                              TextSpan(
                                text: '${DateFormat.Md(context.locale.languageCode).format(reservation.to!)})',
                                style: circularBook(color: kWhite, fontSize: 14),
                              )
                            ]),
                          ),
                        ],
                      ),
                      Text(
                        reservation.status!,
                        style: circularMedium(
                            color: getColorByStatus(reservation.status!),
                            fontSize: 14
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
      onTap: () {
        if (reservation.status == reservationPendingStatus) {
          navigationKey.currentState
              ?.pushNamed(ReservationDetailsPendingScreen.tag, arguments: reservation.id.toString());
        } else {
          navigationKey.currentState
              ?.pushNamed(ReservationDetailsRentedScreen.tag, arguments: reservation.id.toString());
        }
        // switch (reservation.status) {
        //   case "pending":
        //
        //     break;
        //   case "approved":
        //
        //     break;
        // }
      },
    );
  }
}