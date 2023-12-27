import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/extensions/build_context_extensions.dart';
import 'package:spotx/utils/style/theme.dart';

class RoomsSectionWidget extends StatelessWidget {
  const RoomsSectionWidget(
      {Key? key,
      required this.allRoomsNumbersSelected,
      required this.selectedRoomsNumbers,
      required this.roomsNumbers,
      required this.addSetRoomsEvent,
      required this.addSelectAllRoomsEvent})
      : super(key: key);

  final bool allRoomsNumbersSelected;
  final List<int> selectedRoomsNumbers;
  final List<int> roomsNumbers;
  final Function(List<int>) addSetRoomsEvent;
  final Function addSelectAllRoomsEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 20, start: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.roomsNumber.tr(),
            style: circularBook(color: kWhite, fontSize: 17),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            margin: const EdgeInsetsDirectional.only(top: 11),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: (allRoomsNumbersSelected)
                                ? Border.all(color: Theme.of(context).primaryColorLight, width: .5)
                                : Border.all(color: Theme.of(context).splashColor, width: .5),
                            color: (allRoomsNumbersSelected) ? Theme.of(context).primaryColorLight : Colors.transparent),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Text(LocaleKeys.all.tr(),
                              style: circularBook(
                                  color: (allRoomsNumbersSelected ? kWhite : Theme.of(context).splashColor), fontSize: 14)),
                        )),
                    onTap: () {
                      addSelectAllRoomsEvent.call();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(children: buildRoomList(context)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildRoomList(BuildContext context) {
    final cards = <Widget>[];
    roomsNumbers.asMap().forEach((key, value) {
      {
        cards.add(Row(
          children: [
            GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: (selectedRoomsNumbers.contains(value))
                          ? Border.all(color: Theme.of(context).primaryColorLight, width: .5)
                          : Border.all(color: Theme.of(context).splashColor, width: .5),
                      color: (selectedRoomsNumbers.contains(value)) ? Theme.of(context).primaryColorLight : Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(value.replaceFarsiNumber(),
                        style: circularBook(
                            color: ((selectedRoomsNumbers.contains(value)) ? kWhite : Theme.of(context).splashColor),
                            fontSize: 14)),
                  )),
              onTap: () {
                var indexList = selectedRoomsNumbers.map((e) => e).toList();
                if (selectedRoomsNumbers.contains(value)) {
                  indexList.remove(value);
                } else {
                  indexList.add(value);
                }
                addSetRoomsEvent(indexList);
              },
            ),
            if (key != roomsNumbers.length - 1)
              const SizedBox(
                width: 10,
              )
          ],
        ));
      }
    });
    return cards;
  }
}