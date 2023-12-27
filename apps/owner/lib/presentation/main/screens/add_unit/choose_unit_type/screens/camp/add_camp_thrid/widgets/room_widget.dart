import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';

class RoomWidget extends StatelessWidget {
  const RoomWidget({Key? key, required this.room, required this.deleteAction, required this.editAction}) : super(key: key);
  final Room room;
  final Function deleteAction;
  final Function editAction;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(const Radius.circular(20)), color: Theme.of(context).backgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.model!,
                  style: circularBook(color: Theme.of(context).dialogBackgroundColor, fontSize: 13),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  " ${room.count} ${LocaleKeys.room.tr()}",
                  style: circularMedium(color: kWhite, fontSize: 17),
                )
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  child: Image.asset(editIconPath, color: kWhite),
                  onTap: () {
                    editAction.call();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: Image.asset(deleteIconPath, color: kWhite),
                  onTap: () {
                    deleteAction.call();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}