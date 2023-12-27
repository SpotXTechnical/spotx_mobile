import 'package:flutter/material.dart';
import 'package:spotx/utils/widgets/CustomClipRect.dart';

import '../../../../../../../data/remote/regions/models/get_regions_response_entity.dart';
import '../../../../../../../utils/navigation/navigation_helper.dart';
import '../../../../../../../utils/style/theme.dart';
import '../../sub_region/sub_region_details_screen.dart';

class RegionCard extends StatelessWidget {
  const RegionCard(
      {Key? key,
      required this.region,
      this.isSelected = false,
      this.multiSelectMode = false,
      required this.onItemSelected})
      : super(key: key);
  final Region region;
  final bool isSelected;
  final bool multiSelectMode;
  final Function(int, Region) onItemSelected;
  @override
  Widget build(BuildContext context) {
    debugPrint("Image url: ${region.images?[0].url}");
    return GestureDetector(
      onTap: () {
        if (multiSelectMode) {
          onItemSelected(region.id!, region);
        } else {
          navigationKey.currentState?.pushNamed(SubRegionDetailsScreen.tag, arguments: region.id);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(14))),
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (multiSelectMode)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(500)),
                      color:
                          isSelected ? Theme.of(context).primaryColorLight : Theme.of(context).scaffoldBackgroundColor),
                ),
              Column(
                children: [
                  CustomClipRect(
                    path: region.images?[0].url,
                    borderRadius: const BorderRadius.all(Radius.circular(17.6)),
                    height: 89,
                    width: 89,
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(top: 12),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      child: Text(
                        region.name!,
                        style: circularBook(color: kWhite, fontSize: 17),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}