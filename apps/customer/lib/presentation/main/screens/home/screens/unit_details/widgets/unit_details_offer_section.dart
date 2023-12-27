import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/data/remote/unit/model/offer_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/myrents/screens/reservation_details/widget/reservation_details_info.dart';
import 'package:spotx/utils/style/theme.dart';

class UnitDetailsOfferSection extends StatelessWidget {
  const UnitDetailsOfferSection({Key? key, required this.offer}) : super(key: key);
  final OfferEntity offer;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(top: 22, start: 24, end: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.reservation.tr(),
                style: circularMedium(color: kWhite, fontSize: 15),
              ),
            ],
          ),
        ),
        ReservationDetailsInfoWidget(
          toDate: offer.endDate!,
          fromDate: offer.startDate !,
          daysCount: offer.dayCount!,
          price: offer.totalPrice!,
        ),
      ],
    );
  }

  detectOfferRange() {
    offer.unit?.activeRanges?.forEach((element) {
      if (element.from.toString() == offer.from.toString() && element.to.toString() == offer.to.toString()) {
        element.isComingFromOfferScreen = true;
      }
    });
  }
}