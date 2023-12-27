import 'package:flutter/material.dart';
import 'package:spotx/utils/widgets/shimmer_skeleton.dart';

class SubRegionCardShimmer extends StatelessWidget {
  const SubRegionCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).hoverColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          children: [
            ShimmerSkeleton(
              child: Container(
                width: 89,
                height: 89,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(17.6)),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            ShimmerSkeleton(
              child: Container(
                margin: const EdgeInsetsDirectional.only(top: 12),
                height: 20,
                width: 180,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
