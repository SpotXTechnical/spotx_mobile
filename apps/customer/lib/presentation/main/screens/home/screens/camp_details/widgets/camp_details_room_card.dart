import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';

import '../../../../../../../data/remote/unit/model/unit_response_entity.dart';

class CampDetailsRoomCard extends StatelessWidget {
  const CampDetailsRoomCard({Key? key, required this.onRoomClicked, required this.room}) : super(key: key);

  final Function(Room) onRoomClicked;
  final Room room;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Theme.of(context).unselectedWidgetColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(color: Theme.of(context).unselectedWidgetColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            sampleImagePath,
                            fit: BoxFit.cover,
                          ),
                        )),
                    Container(
                      margin: const EdgeInsetsDirectional.only(start: 8),
                      width: MediaQuery.of(context).size.width * .565,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(top: 9.0),
                            decoration: BoxDecoration(
                                color: Theme.of(context).dialogBackgroundColor,
                                borderRadius: BorderRadius.all(Radius.circular(11))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                              child: Text(
                                "See View",
                                style: circularMedium(color: Theme.of(context).primaryColorLight, fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                    margin: const EdgeInsetsDirectional.only(top: 8, start: 5),
                    child: Text(
                      room.title ?? "BackEnd Empty Data",
                      style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 13),
                    )),
                Container(
                    margin: const EdgeInsetsDirectional.only(top: 9, start: 5),
                    child: Row(
                      children: [
                        Text(
                          room.defaultPrice.toString(),
                          style: circularMedium(color: kWhite, fontSize: 15),
                        ),
                        Text(
                          LocaleKeys.perDayWithoutSlash.tr(),
                          style: circularMedium(color: Theme.of(context).disabledColor, fontSize: 15),
                        ),
                      ],
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .6,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              border: Border.all(color: Theme.of(context).disabledColor)),
                          margin: const EdgeInsetsDirectional.only(top: 9, start: 5),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Row(
                              children: [
                                Text(
                                  room.beds.toString(),
                                  style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 13),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Image.asset(bedRoomIconPath, color: kWhite)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              border: Border.all(color: Theme.of(context).disabledColor)),
                          margin: const EdgeInsetsDirectional.only(top: 9, start: 5),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Row(
                              children: [
                                Text(
                                  room.bathrooms.toString(),
                                  style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 13),
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Image.asset(bathTubIconPath, color: kWhite)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        onRoomClicked.call(room);
      },
    );
  }
}