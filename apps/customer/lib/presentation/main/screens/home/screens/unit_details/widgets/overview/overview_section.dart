import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:readmore/readmore.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/overview/widgets/unit_details_content_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/overview/widgets/unit_details_home_features.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/overview/widgets/unit_details_owner_details.dart';
import 'package:spotx/utils/const.dart';
import 'package:spotx/utils/utils.dart';

import '../../../../../../../../data/remote/unit/model/unit_response_entity.dart';
import '../../../../../../../../generated/locale_keys.g.dart';
import '../../../../../../../../utils/images.dart';
import '../../../../../../../../utils/style/theme.dart';
import '../../../../../../../../utils/widgets/locale_icon_direction.dart';
import '../../../../../../../../utils/widgets/maps/google_maps.dart';

class OverViewSection extends StatelessWidget {
  const OverViewSection({Key? key, required this.unit}) : super(key: key);

  final Unit unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UnitDetailsOwnerDetails(owner: unit.owner!),
        Container(
          margin: const EdgeInsetsDirectional.only(top: 17, start: 24, end: 24),
          child: ReadMoreText(
            unit.description ?? '',
            trimLines: 3,
            style: const TextStyle(
                height: 1.5,
                fontSize: 14,
                color: kWhite,
                fontWeight: FontWeight.w400),
            colorClickableText: Theme.of(context).primaryColorLight,
            trimMode: TrimMode.Line,
            trimCollapsedText: LocaleKeys.readMore.tr(),
            trimExpandedText: LocaleKeys.readLess.tr(),
            moreStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ),
        UnitDetailsContentWidget(
          bathrooms: unit.bathrooms!,
          bedrooms: unit.bedRooms!,
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
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 15),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: GoogleMaps(
                      lat: double.parse(unit.latitude ?? "0"),
                      lng: double.parse(unit.longitude ?? "0"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 15),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.transparent,
                  ),
                  GestureDetector(
                    onTap: () {
                      MapsLauncher.launchCoordinates(
                          double.parse(unit.latitude ?? "0"),
                          double.parse(unit.longitude ?? "0"),
                          unit.regionName);
                    },
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
                            color: Theme.of(context).scaffoldBackgroundColor),
                        child: const Icon(Icons.my_location)),
                  )
                ],
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
            margin:
                const EdgeInsetsDirectional.only(start: 24, end: 24, top: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.cancellationPolicy.tr(),
                      style: circularMedium(color: kWhite, fontSize: 19),
                    ),
                  ],
                ),
                const LocaleIconDirection(
                  icon: arrowIconPath,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}