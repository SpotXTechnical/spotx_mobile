import 'package:flutter/material.dart';
import 'package:spotx/presentation/widgets/shimmers/region_medium_card_shimmer.dart';
import 'package:spotx/utils/widgets/shimmer_skeleton.dart';

class HomeMostPopularRegionsShimmer extends StatelessWidget {
  const HomeMostPopularRegionsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerSkeleton(
              child: Container(width: 80, height: 20, color: Theme.of(context).colorScheme.secondary),
            ),
            ShimmerSkeleton(
              child: Container(
                  margin: const EdgeInsetsDirectional.only(end: 24),
                  width: 80,
                  height: 20,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsetsDirectional.only(top: 17),
          height: 130,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return const Divider(
                indent: 15,
              );
            },
            itemBuilder: (BuildContext context, int index) => const RegionMediumCardShimmer(),
          ),
        ),
      ],
    );
  }
}
