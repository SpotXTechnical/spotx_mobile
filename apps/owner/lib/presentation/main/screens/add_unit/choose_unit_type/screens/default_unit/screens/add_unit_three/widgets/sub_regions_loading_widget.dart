import 'package:flutter/material.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/add_unit_three/widgets/sub_regions_card_shimmer.dart';

class SubRegionsLoadingWidget extends StatelessWidget {
  const SubRegionsLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return const Divider(
            indent: 15,
          );
        },
        itemBuilder: (BuildContext context, int index) => const SubRegionCardShimmer(),
      ),
    );
  }
}
