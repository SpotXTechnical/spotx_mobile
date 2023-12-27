import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/regions_section_widget.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/CustomClipRect.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

Widget buildRegionSection(
    List<Region> regions, Region selectedRegion, Function(Region) setRegionAction, TextEditingController controller) {
  if (regions.isNotEmpty) {
    return RegionSectionWidget(
      title: LocaleKeys.region.tr(),
      selectedRegion: selectedRegion,
      regions: regions,
      controller: controller,
      addSetRegionEvent: (selectedRegion) {
        setRegionAction(selectedRegion);
      },
    );
  } else {
    return Container(margin: const EdgeInsets.only(top: 20), child: const LoadingWidget());
  }
}

void showAndroidBottomSheet(BuildContext context, List<Unit> list, String selectedUnitId, Function(Unit) action) {
  showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (context) => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: createList(list, selectedUnitId, action, context),
            ),
          ));
}

List<Widget> createList(List<Unit> list, String selectedUnitId, Function(Unit) action, BuildContext context) {
  List<Widget> widgets = List.empty(growable: true);
  for (var element in list) {
    widgets.add(ListTile(
      leading: CustomClipRect(
        width: 40,
        height: 40,
        borderRadius: BorderRadius.circular(8),
        path: element.mainImage?.url,
        errorWidget: const SizedBox(
          width: 40,
          height: 40,
        ),
      ),
      title: Text(
        element.title ?? "",
        style: TextStyle(color: kWhite),
      ),
      onTap: () {
        Navigator.of(context).pop();
        action(element);
      },
      trailing: element.id == selectedUnitId ? Image.asset(doneIconPath, color: kWhite) : null,
    ));
  }
  return widgets;
}