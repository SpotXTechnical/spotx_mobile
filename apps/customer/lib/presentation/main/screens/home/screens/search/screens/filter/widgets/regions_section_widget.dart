import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/style/theme.dart';

class RegionSectionWidget extends StatelessWidget {
  const RegionSectionWidget(
      {Key? key,
      required this.allRegionsSelected,
      required this.selectedRegions,
      required this.regions,
      required this.addSetRegionEvent,
      required this.addSelectAllRegionsEvent})
      : super(key: key);

  final bool allRegionsSelected;
  final List<Region> selectedRegions;
  final List<Region> regions;
  final Function(List<Region>) addSetRegionEvent;
  final Function addSelectAllRegionsEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 20, start: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.region.tr(),
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
                            border: (allRegionsSelected)
                                ? Border.all(color: Theme.of(context).primaryColorLight, width: .5)
                                : Border.all(color: Theme.of(context).splashColor, width: .5),
                            color: (allRegionsSelected) ? Theme.of(context).primaryColorLight : Colors.transparent),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Text(LocaleKeys.all.tr(),
                              style: circularBook(
                                  color: (allRegionsSelected
                                      ? kWhite
                                      : Theme.of(context).splashColor),
                                  fontSize: 14)),
                        )),
                    onTap: () {
                      addSelectAllRegionsEvent.call();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                      children: buildRegionList(
                          regions, selectedRegions.map((e) => e.id!).toList(), addSetRegionEvent, context)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> buildRegionList(
      List<Region> regions, List<int> selectedRegions, Function addSetRegionEvent, BuildContext context) {
    final widgets = <Widget>[];
    regions.asMap().forEach((key, value) {
      {
        widgets.add(Row(
          children: [
            GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: (selectedRegions.contains(value.id))
                          ? Border.all(color: Theme.of(context).primaryColorLight, width: .5)
                          : Border.all(color: Theme.of(context).splashColor, width: .5),
                      color: (selectedRegions.contains(value.id))
                          ? Theme.of(context).primaryColorLight
                          : Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(regions[key].name!,
                        style: circularBook(
                            color: ((selectedRegions.contains(value.id))
                                ? kWhite
                                : Theme.of(context).splashColor),
                            fontSize: 14)),
                  )),
              onTap: () {
                var indexList = selectedRegions.map((e) => e).toList();
                if (selectedRegions.contains(value.id)) {
                  indexList.remove(value.id);
                } else {
                  indexList.add(value.id!);
                }
                addSetRegionEvent(regions.where((element) => indexList.contains(element.id)).toList());
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