import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:spotx/base/sub_region/region_event.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/presentation/common/filter_sub_region_bottom_sheet_modal.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/CustomRoundedTextFormField.dart';

class SubRegionsSectionManyChoicesWidget extends StatelessWidget {
  const SubRegionsSectionManyChoicesWidget(
      {Key? key,
      this.selectedSubRegions,
      required this.setSubRegionListEvent,
      required this.title,
      this.controller,
      required this.selectedRegions,
      required this.setRegionListEvent})
      : super(key: key);

  final String title;
  final List<Region>? selectedSubRegions;
  final Function(List<Region>) setSubRegionListEvent;
  final Function(List<Region>?) setRegionListEvent;
  final TextEditingController? controller;
  final List<Region>? selectedRegions;
  final String searchText = "";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsetsDirectional.only(top: 20, start: 23, end: 23),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.subRegion.tr(),
                  style: circularBook(color: kWhite, fontSize: 17),
                ),
                selectedSubRegions != null && selectedSubRegions!.isNotEmpty
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsetsDirectional.only(top: 11),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: createChipsList(selectedSubRegions!, context),
                        ))
                    : Container(
                        margin: const EdgeInsets.only(
                          top: 11,
                        ),
                        child: CustomRoundedTextFormField(
                          enabled: false,
                          suffixIcon: Image.asset(arrowDownIconPath, color: kWhite),
                          controller: controller,
                          hintText: LocaleKeys.pleaseChooseSubRegionHint.tr(),
                          style: circularBook(
                            color: cadetGrey,
                            fontSize: 15,
                          ),
                          hasBorder: true,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (name) {},
                          validator: (value) {
                            if (selectedRegions == null) {
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        if (selectedRegions != null) {
          showFilterBottomSheetModal(
              context,
              InitSubRegions(
                  regionIds: selectedRegions?.map((e) => e.id.toString()).toList(), subregionsList: selectedSubRegions),
              searchText,
              selectedRegions,
              (isAllSelected, selectedSubRegions) => {
                    if (isAllSelected)
                      {setRegionListEvent(selectedRegions)}
                    else if (selectedSubRegions != null)
                      {setSubRegionListEvent(selectedSubRegions)}
                  },
              LoadMoreSubRegions(regionIds: selectedRegions?.map((e) => e.toString()).toList()));
        }
      },
    );
  }
}

List<Widget> createChipsList(List<Region> selectedSubRegions, BuildContext context) {
  List<Widget> widgets = List.empty(growable: true);
  selectedSubRegions.asMap().forEach((key, value) {
    {
      widgets.add(Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Theme.of(context).primaryColorLight, width: .5),
            color: Theme.of(context).primaryColorLight,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(value.name!, style: circularBook(color: kWhite, fontSize: 14)),
          )));
    }
  });
  return widgets;
}