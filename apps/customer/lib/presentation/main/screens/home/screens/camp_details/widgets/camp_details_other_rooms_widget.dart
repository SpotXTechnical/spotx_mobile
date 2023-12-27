import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/model/unit_details_screen_nav_args.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/unit_details_screen.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';

import 'camp_details_room_card.dart';

class CampDetailsOtherRoomsWidget extends StatelessWidget {
  const CampDetailsOtherRoomsWidget({Key? key, required this.rooms, required this.onRoomClicked}) : super(key: key);
  final List<Room> rooms;
  final Function(Room) onRoomClicked;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 24, top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.otherRoomsInTheSameCamp.tr(),
                style: circularMedium(color: kWhite, fontSize: 19),
              ),
            ],
          ),
          Container(
            height: 270,
            margin: const EdgeInsetsDirectional.only(top: 17),
            child: ListView.separated(
              itemCount: rooms.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const Divider(
                  indent: 15,
                );
              },
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                child: rooms.isNotEmpty
                    ? CampDetailsRoomCard(
                        room: rooms[index],
                        onRoomClicked: (room) {
                          onRoomClicked(room);
                        },
                      )
                    : Container(),
                onTap: () {
                  // navigateToUnitDetails(state.mostPopularUnits![index]);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void navigateToUnitDetails(Unit unit) {
    navigationKey.currentState?.pushNamed(UnitDetailsScreen.tag,
        arguments: UnitDetailsScreenNavArgs(unit.id.toString(), UnitDetailsScreenType.normalUnit));
  }
}