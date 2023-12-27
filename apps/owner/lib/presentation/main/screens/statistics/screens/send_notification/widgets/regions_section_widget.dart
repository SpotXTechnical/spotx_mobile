import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/style/theme.dart';

class RegionSectionWidget extends StatelessWidget {
  const RegionSectionWidget({
    Key? key,
    required this.selectedRegion,
    required this.regions,
    required this.addSetRegionEvent,
    required this.title,
    required this.isAllSelected,
    required this.allSelectedAction,
  }) : super(key: key);

  final String title;
  final int? selectedRegion;
  final List<Region> regions;
  final Function(int) addSetRegionEvent;
  final Function() allSelectedAction;
  final bool isAllSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 10, start: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: circularBook(color: kWhite, fontSize: 17),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            margin: const EdgeInsets.only(top: 11),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: (isAllSelected)
                                ? Border.all(color: Theme.of(context).primaryColorLight, width: .5)
                                : Border.all(color: Theme.of(context).splashColor, width: .5),
                            color: (isAllSelected) ? Theme.of(context).primaryColorLight : Colors.transparent),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Text(LocaleKeys.all.tr(),
                              style:
                                  circularBook(color: ((isAllSelected) ? kWhite : Theme.of(context).splashColor), fontSize: 14)),
                        )),
                    onTap: () {
                      if (!isAllSelected) {
                        allSelectedAction.call();
                      }
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(children: buildRegionList(regions, selectedRegion, addSetRegionEvent, isAllSelected, context)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildRegionList(List<Region> regions, int? selectedRegion, Function addSetRegionEvent, bool isAllSelected, BuildContext context) {
    final widgets = <Widget>[];
    regions.asMap().forEach((key, value) {
      {
        widgets.add(Row(
          children: [
            GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: (selectedRegion == value.id && !isAllSelected)
                          ? Border.all(color: Theme.of(context).primaryColorLight, width: .5)
                          : Border.all(color: Theme.of(context).splashColor, width: .5),
                      color: (selectedRegion == value.id && !isAllSelected) ? Theme.of(context).primaryColorLight : Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(regions[key].name!,
                        style: circularBook(
                            color: ((selectedRegion == value.id && !isAllSelected) ? kWhite : Theme.of(context).splashColor),
                            fontSize: 14)),
                  )),
              onTap: () {
                if (selectedRegion != value.id) {
                  addSetRegionEvent(value.id);
                }
              },
            ),
            if (key != regions.length - 1)
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