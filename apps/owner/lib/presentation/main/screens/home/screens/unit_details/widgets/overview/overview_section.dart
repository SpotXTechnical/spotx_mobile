import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/widgets/overview/widgets/unit_details_content_widget.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/widgets/overview/widgets/unit_details_home_features.dart';
import 'package:owner/utils/const.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/utils.dart';
import 'package:owner/utils/widgets/locale_icon_direction.dart';
import 'package:owner/utils/widgets/maps/google_maps.dart';
import 'package:readmore/readmore.dart';

class OverViewSection extends StatelessWidget {
  const OverViewSection({Key? key, required this.unit}) : super(key: key);
  final Unit unit;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(top: 0, start: 24, end: 24),
          child: ReadMoreText(
            unit.description??'',
            trimLines: 3,
            style: const TextStyle(height: 1.5, fontSize: 14, color: kWhite, fontWeight: FontWeight.w400),
            colorClickableText: Theme.of(context).primaryColorLight,
            trimMode: TrimMode.Line,
            trimCollapsedText: LocaleKeys.readeMore.tr(),
            trimExpandedText: LocaleKeys.readLess.tr(),
            moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ),
        UnitDetailsContentWidget(
          bathrooms: unit.bathRooms!,
          bedrooms: unit.bedRooms!,
          maxNumberOfGuests: unit.maxNumberOfGuests??'5',
        ),
        UnitDetailsHomeFeatures(
          features: unit.features!,
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.location.tr(),
                style: circularMedium(color: kWhite, fontSize: 19),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(top: 15),
                width: MediaQuery.of(context).size.width,
                height: 200,
                child:  GoogleMaps(
                  lat: double.parse(unit.latitude ?? "30.0444"),
                  lng: double.parse(unit.longitude ?? "31.2357"),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 22),
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: Theme.of(context).unselectedWidgetColor,
        ),
        if(unit.isFamiliesOnly == 1) ...[
          Container(
            margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 17),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.onlyFamilies.tr(),
                      style: circularMedium(color: kWhite, fontSize: 19),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(top: 5),
                      child: Text(
                        LocaleKeys.onlyFamiliesMessage.tr(),
                        style: circularMedium(color: kWhite, fontSize: 13),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 22),
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Theme.of(context).unselectedWidgetColor,
          ),
        ],
        GestureDetector(
          onTap: () {
            launchURLInAppBrowser(cancellationPolicy);
          },
          child: Container(
            margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.cancellationPolicy.tr(),
                  style: circularMedium(color: kWhite, fontSize: 19),
                ),
                const LocaleIconDirection(icon: arrowRightIconPath)
              ],
            ),
          ),
        ),
      ],
    );
  }
}