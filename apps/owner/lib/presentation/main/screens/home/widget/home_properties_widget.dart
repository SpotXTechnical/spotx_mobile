import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/style/theme.dart';

class HomePropertiesWidget extends StatelessWidget {
  const HomePropertiesWidget(
      {Key? key,
      required this.isAllSelected,
      required this.selectedRegion,
      required this.regions,
      required this.addSetRegionEvent,
      required this.addSelectAllRegionsEvent})
      : super(key: key);

  final bool isAllSelected;
  final List<int> selectedRegion;
  final List<Region> regions;
  final Function(int) addSetRegionEvent;
  final Function addSelectAllRegionsEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsetsDirectional.only(top: 11.5, start: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.properties.tr(),
            style: circularBook(color: kWhite, fontSize: 17),
          ),
          Container(
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
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text(LocaleKeys.all.tr(),
                              style:
                                  circularBook(color: (isAllSelected ? kWhite : Theme.of(context).splashColor), fontSize: 14)),
                        )),
                    onTap: () {
                      addSelectAllRegionsEvent.call();
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
    regions.asMap().forEach((key, value) {
      {
        widgets.add(Row(
          children: [
            GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: (selectedRegion.isNotEmpty && selectedRegion[0] == value.id!)
                          ? Border.all(color: Theme.of(context).primaryColorLight, width: .5)
                          : Border.all(color: Theme.of(context).splashColor, width: .5),
                      color:
                          (selectedRegion.isNotEmpty && selectedRegion[0] == value.id!) ? Theme.of(context).primaryColorLight : Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(regions[key].name!,
                        style: circularBook(
                            color: ((selectedRegion.isNotEmpty && selectedRegion[0] == value.id!)
                                ? kWhite
                                : Theme.of(context).splashColor),
                            fontSize: 14)),
                  )),
              onTap: () {
                addSetRegionEvent(value.id!);
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