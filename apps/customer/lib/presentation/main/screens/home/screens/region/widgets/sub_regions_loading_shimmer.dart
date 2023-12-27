import 'package:flutter/material.dart';
import 'package:spotx/presentation/widgets/shimmers/region_medium_card_shimmer.dart';

class SubRegionsLoadingShimmer extends StatelessWidget {
  const SubRegionsLoadingShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 17, bottom: 20),
        child: GridView.builder(
          itemCount: 10,
          controller: ScrollController(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => RegionMediumCardShimmer(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
        ),
      ),
    );
  }
}
