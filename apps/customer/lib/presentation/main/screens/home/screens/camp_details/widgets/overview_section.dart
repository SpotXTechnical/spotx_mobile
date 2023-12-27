import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/overview/widgets/unit_details_content_widget.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/overview/widgets/unit_details_home_features.dart';
import 'package:readmore/readmore.dart';

import '../../../../../../../../data/remote/unit/model/unit_response_entity.dart';
import '../../../../../../../../generated/locale_keys.g.dart';
import '../../../../../../../../utils/images.dart';
import '../../../../../../../../utils/style/theme.dart';
import '../../../../../../../../utils/widgets/locale_icon_direction.dart';
import '../../../../../../../../utils/widgets/maps/google_maps.dart';
import 'camp_details_other_rooms_widget.dart';

class OverViewSection extends StatelessWidget {
  const OverViewSection({Key? key, required this.unit, required this.onRoomClicked}) : super(key: key);
  final Unit unit;
  final Function(Room) onRoomClicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(top: 17, start: 24, end: 24),
          child: ReadMoreText(
            unit.description!,
            trimLines: 3,
            style:
                TextStyle(height: 1.5, fontSize: 14, color: kWhite, fontWeight: FontWeight.w400),
            colorClickableText: Theme.of(context).primaryColorLight,
            trimMode: TrimMode.Line,
            trimCollapsedText: LocaleKeys.readMore.tr(),
            trimExpandedText: LocaleKeys.readLess.tr(),
            moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ),
        UnitDetailsContentWidget(
          bathrooms: unit.bathrooms!,
          bedrooms: unit.bedRooms!,
        ),
        UnitDetailsHomeFeatures(
          features: unit.features!,
        ),
        unit.rooms != null && unit.rooms!.isNotEmpty
            ? CampDetailsOtherRoomsWidget(
                rooms: unit.rooms!,
                onRoomClicked: (room) {
                  onRoomClicked.call(room);
                },
              )
            : Container(),
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
                  lat: double.parse(unit.latitude ?? "0"),
                  lng: double.parse(unit.longitude ?? "0"),
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
        Container(
          margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 17),
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
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 5),
                    child: Text(
                      "Free - free Cancellation",
                      style: circularMedium(color: kWhite, fontSize: 13),
                    ),
                  )
                ],
              ),
              const LocaleIconDirection(
                icon: arrowIconPath,
              )
            ],
          ),
        ),
      ],
    );
  }
}