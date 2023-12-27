import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/custom_titiled_rounded_text_form.dart';

class RegionSectionWidget extends StatelessWidget {
  const RegionSectionWidget({
    Key? key,
    this.selectedRegion,
    required this.regions,
    required this.addSetRegionEvent,
    required this.title,
    this.controller,
  }) : super(key: key);

  final String title;
  final Region? selectedRegion;
  final List<Region>? regions;
  final Function(Region) addSetRegionEvent;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    List<Region>? newList = regions?.map((e) => e.clone()).toList();
    if (selectedRegion != null) {
      newList?.removeWhere((element) => element.id == selectedRegion?.id);
      newList?.insert(0, selectedRegion!);
    }
    return Stack(
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
          child: CustomTitledRoundedTextFormWidget(
            suffixIcon: Image.asset(arrowDownIcon, color: kWhite),
            controller: controller,
            hintText: LocaleKeys.pleaseChooseRegionHint.tr(),
            title: LocaleKeys.region.tr(),
            textStyle: circularBook(color: Theme.of(context).dividerColor, fontSize: 15),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (name) {},
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return LocaleKeys.validationInsertData.tr();
              } else {
                return null;
              }
            },
          ),
        ),
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: 80,
          ),
          onTap: () {
            showModalBottomSheet(
                context: context,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                builder: (context) => Container(
                      margin: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Text(LocaleKeys.selectARegion.tr(),
                              style: circularBook(color: kWhite, fontSize: 17)),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: newList?.length ?? 0,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8.0),
                                    child: Text(
                                      newList?.elementAt(index).name ?? "",
                                      style: circularBook(
                                          color: index == 0 && selectedRegion != null
                                              ? Theme.of(context).canvasColor
                                              : Theme.of(context).hintColor,
                                          fontSize: 15),
                                    ),
                                  ),
                                  onTap: () {
                                    var element = newList?.elementAt(index);
                                    if (element != null) {
                                      addSetRegionEvent(element);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 3,
                                  color: Theme.of(context).backgroundColor,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ));
          },
        ),
      ],
    );
  }
}