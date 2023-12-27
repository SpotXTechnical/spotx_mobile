import 'package:flutter/material.dart';
import 'package:spotx/presentation/main/screens/home/widget/shimmer/home_most_popular_regions_shimmer.dart';

class HomeSubRegionLoadingWidget extends StatelessWidget {
  const HomeSubRegionLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 17),
      height: 58,
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
        itemBuilder: (BuildContext context, int index) => const HomeMostPopularRegionsShimmer(),
      ),
    );
  }
}
