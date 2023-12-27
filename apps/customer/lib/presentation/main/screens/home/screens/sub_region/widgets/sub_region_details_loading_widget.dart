import 'package:flutter/material.dart';
import 'package:spotx/presentation/main/screens/home/screens/sub_region/widgets/sub_region_unit_card_shimmer.dart';

class SubRegionDetailsLoadingWidget extends StatelessWidget {
  const SubRegionDetailsLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 24, end: 24, bottom: 20, top: 8),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return Divider(
            indent: 20,
            color: Theme.of(context).backgroundColor,
          );
        },
        itemBuilder: (BuildContext context, int index) => const SubRegionUnitCardShimmer(),
      ),
    );
  }
}
