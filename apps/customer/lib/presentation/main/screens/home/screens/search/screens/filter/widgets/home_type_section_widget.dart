import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/data/remote/unit/model/unit_filter_config_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/style/theme.dart';

class HomeTypeSectionWidget extends StatelessWidget {
  const HomeTypeSectionWidget(
      {Key? key,
      required this.allHomeTypesSelected,
      required this.selectedHomeTypes,
      required this.homeTypes,
      required this.addSetHomeTypesEvent,
      required this.addSelectAllHomeTypesEvent})
      : super(key: key);

  final bool allHomeTypesSelected;
  final List<String> selectedHomeTypes;
  final List<UnitFilterConfigTypes> homeTypes;
  final Function(List<String>) addSetHomeTypesEvent;
  final Function addSelectAllHomeTypesEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsetsDirectional.only(top: 11.5, start: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.homeType.tr(),
            style: circularBook(color: kWhite, fontSize: 17),
          ),
          Container(
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
                            border: (allHomeTypesSelected)
                                ? Border.all(color: Theme.of(context).primaryColorLight, width: .5)
                                : Border.all(color: Theme.of(context).splashColor, width: .5),
                            color: (allHomeTypesSelected) ? Theme.of(context).primaryColorLight : Colors.transparent),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Text(LocaleKeys.all.tr(),
                              style: circularBook(
                                  color: (allHomeTypesSelected ? kWhite : Theme.of(context).splashColor), fontSize: 14)),
                        )),
                    onTap: () {
                      addSelectAllHomeTypesEvent.call();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: buildHomeTypeList(context),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildHomeTypeList(BuildContext context) {
    final widgets = <Widget>[];
    homeTypes.asMap().forEach((key, value) {
      {
        widgets.add(Row(
          children: [
            GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: (selectedHomeTypes.contains(value.value))
                          ? Border.all(color: Theme.of(context).primaryColorLight, width: .5)
                          : Border.all(color: Theme.of(context).splashColor, width: .5),
                      color: (selectedHomeTypes.contains(value.value)) ? Theme.of(context).primaryColorLight : Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(value.value!,
                        style: circularBook(
                            color: ((selectedHomeTypes.contains(value.value)) ? kWhite : Theme.of(context).splashColor),
                            fontSize: 14)),
                  )),
              onTap: () {
                var indexList = selectedHomeTypes.map((e) => e).toList();
                if (selectedHomeTypes.contains(value.value)) {
                  indexList.remove(value.value);
                } else {
                  indexList.add(value.value!);
                }
                addSetHomeTypesEvent(indexList);
              },
            ),
            if (key != homeTypes.length - 1)
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