import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/extensions/build_context_extensions.dart';
import 'package:spotx/utils/style/theme.dart';

class BedSectionWidget extends StatelessWidget {
  const BedSectionWidget(
      {Key? key,
      required this.allBedsNumbersSelected,
      required this.selectedBedsNumbers,
      required this.bedsNumbers,
      required this.addSetBedsNumbersEvent,
      required this.addSelectAllBedsNumbersEvent})
      : super(key: key);

  final bool allBedsNumbersSelected;
  final List<int> selectedBedsNumbers;
  final List<int> bedsNumbers;
  final Function(List<int>) addSetBedsNumbersEvent;
  final Function addSelectAllBedsNumbersEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 20, start: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.bedsNumber.tr(),
            style: circularBook(color: kWhite, fontSize: 17),
          ),
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsetsDirectional.only(top: 11),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: (allBedsNumbersSelected)
                                ? Border.all(color: Theme.of(context).primaryColorLight, width: .5)
                                : Border.all(color: Theme.of(context).splashColor, width: .5),
                            color: (allBedsNumbersSelected) ? Theme.of(context).primaryColorLight : Colors.transparent),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Text(LocaleKeys.all.tr(),
                              style: circularBook(
                                  color: (allBedsNumbersSelected ? kWhite : Theme.of(context).splashColor), fontSize: 14)),
                        )),
                    onTap: () {
                      addSelectAllBedsNumbersEvent.call();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: buildBedList(context)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildBedList(BuildContext context) {
    final widgets = <Widget>[];
    bedsNumbers.asMap().forEach((key, value) {
      {
        widgets.add(Row(
          children: [
            GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: (selectedBedsNumbers.contains(value))
                          ? Border.all(color: Theme.of(context).primaryColorLight, width: .5)
                          : Border.all(color: Theme.of(context).splashColor, width: .5),
                      color: (selectedBedsNumbers.contains(value)) ? Theme.of(context).primaryColorLight : Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(value.replaceFarsiNumber(),
                        style: circularBook(
                            color: ((selectedBedsNumbers.contains(value)) ? kWhite : Theme.of(context).splashColor),
                            fontSize: 14)),
                  )),
              onTap: () {
                var indexList = selectedBedsNumbers.map((e) => e).toList();
                if (selectedBedsNumbers.contains(value)) {
                  indexList.remove(value);
                } else {
                  indexList.add(value);
                }
                addSetBedsNumbersEvent(indexList);
              },
            ),
            if (key != bedsNumbers.length - 1)
              const SizedBox(
                width: 10,
              )
          ],
        ));
      }
    });
    return widgets;
  }
}