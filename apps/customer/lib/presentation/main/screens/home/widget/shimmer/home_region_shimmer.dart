import 'package:flutter/material.dart';
import 'package:spotx/presentation/widgets/shimmers/region_medium_card_shimmer.dart';

class HomeRegionShimmer extends StatelessWidget {
  const HomeRegionShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
