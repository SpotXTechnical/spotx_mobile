import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/CustomClipRect.dart';

import '../../../../../../utils/navigation/navigation_helper.dart';
import '../screens/reservation_details/reservation_details_screen.dart';

class ReservationCardWidget extends StatelessWidget {
  const ReservationCardWidget(
      {Key? key, required this.reservation, required this.rejectAction, required this.acceptAction})
      : super(key: key);

  final Reservation reservation;
  final Function(String) rejectAction;
  final Function(String) acceptAction;

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
                      height: 87,
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
                              reservation.unit!.title ?? "",
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
                                            style: circularBook(
                                                color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                                          ),
                                          TextSpan(
                                            text: DateFormat.Md(context.locale.languageCode).format(reservation.from!),
                                            style: circularBook(color: kWhite, fontSize: 14),
                                          ),
                                          TextSpan(
                                            text: ' ${LocaleKeys.to.tr()} ',
                                            style: circularBook(
                                                color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                                          ),
                                          TextSpan(
                                            text: '${DateFormat.Md(context.locale.languageCode).format(reservation.to!)})',
                                            style: circularBook(color: kWhite, fontSize: 14),
                                          )
                                        ]),
                                      ),
                                    ],
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
                  children: [
                    Expanded(
                      flex: 10,
                      child: Row(
                        children: [
                          Text(
                            LocaleKeys.totalCost.tr(),
                            style: circularBook(color: Theme.of(context).dialogBackgroundColor, fontSize: 14),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${reservation.subTotal} ${LocaleKeys.le.tr()}",
                            style: circularMedium(color: kWhite, fontSize: 14),
                          )
                        ],
                      ),
                    ),

                    reservation.status == ReservationStatus.pending.name
                        ? Expanded(
                            flex: 10,
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(22)),
                                          border: Border.all(color: Theme.of(context).canvasColor)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                          child: AutoSizeText(
                                            LocaleKeys.reject.tr(),
                                            minFontSize: 10,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style:
                                                circularBook(color: Theme.of(context).primaryColorLight, fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      if (reservation.isRejectEnabled == null || reservation.isRejectEnabled!) {
                                        rejectAction(reservation.id.toString());
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColorLight,
                                          borderRadius: const BorderRadius.all(Radius.circular(20))),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.only(top: 5, bottom: 5),
                                        child: AutoSizeText(
                                          LocaleKeys.accept.tr(),
                                          minFontSize: 10,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: circularBook(color: kWhite, fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      if (reservation.isAcceptEnabled == null || reservation.isAcceptEnabled!) {
                                        acceptAction(reservation.id.toString());
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : reservation.status == ReservationStatus.approved.name
                            ? Expanded(
                                flex: 10,
                                child: Container(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Text(
                                    LocaleKeys.reserved.tr(),
                                    style: circularMedium(color: Theme.of(context).canvasColor, fontSize: 14),
                                  ),
                                ))
                            : Expanded(
                                flex: 10,
                                child: Container(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Text(
                                    LocaleKeys.rejected.tr(),
                                    style: circularMedium(color: Theme.of(context).splashColor, fontSize: 14),
                                  ),
                                ))
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