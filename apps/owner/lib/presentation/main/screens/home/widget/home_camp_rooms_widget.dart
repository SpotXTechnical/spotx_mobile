import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/utils.dart';

import 'home_unit_card.dart';

class HomeCampRoomsWidget extends StatelessWidget {
  const HomeCampRoomsWidget({Key? key, required this.camp}) : super(key: key);
  final Unit camp;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isArabic ? const EdgeInsetsDirectional.only(end: 24, top: 24) : const EdgeInsets.only(left: 24, top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                camp.titleEn!,
                style: circularMedium(color: kWhite, fontSize: 19),
              ),
              GestureDetector(
                child: Container(
                  color: Colors.transparent,
                  margin: isArabic ? const EdgeInsetsDirectional.only(start: 27) : const EdgeInsetsDirectional.only(end: 27),
                  child: Text(
                    LocaleKeys.viewAll.tr(),
                    style: circularMedium(color: Theme.of(context).dialogBackgroundColor, fontSize: 12),
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
          Container(
            height: 270,
            margin: const EdgeInsets.only(top: 17),
            child: ListView.separated(
              itemCount: camp.rooms!.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const Divider(
                  indent: 15,
                );
              },
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                  child: HomeRoomCard(
                room: camp.rooms![index],
                type: camp.type!,
              )),
            ),
          )
        ],
      ),
    );
  }
}