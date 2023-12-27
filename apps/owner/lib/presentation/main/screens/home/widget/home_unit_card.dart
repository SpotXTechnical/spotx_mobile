import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/CustomClipRect.dart';

class HomeRoomCard extends StatelessWidget {
  const HomeRoomCard({Key? key, required this.room, required this.type}) : super(key: key);
  final Room room;
  final String type;
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
                        child: CustomClipRect(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    Container(
                      margin: const EdgeInsetsDirectional.only(start: 8, top: 8),
                      width: MediaQuery.of(context).size.width * .565,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).dialogBackgroundColor,
                                borderRadius: const BorderRadius.all(Radius.circular(11))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                              child: Text(
                                type,
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
                      room.model ?? "",
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
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              border: Border.all(color: Theme.of(context).disabledColor)),
                          margin: const EdgeInsetsDirectional.only(top: 9, start: 5),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Row(
                              children: [
                                Text(
                                  "${room.beds}",
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
                                  "${room.bathrooms}",
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
    );
  }
}