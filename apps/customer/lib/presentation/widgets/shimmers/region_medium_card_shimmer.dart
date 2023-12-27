import 'package:flutter/material.dart';
import 'package:spotx/utils/widgets/shimmer_skeleton.dart';

class RegionMediumCardShimmer extends StatelessWidget {
  const RegionMediumCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor, borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: ShimmerSkeleton(
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        20,
                      ),
                      topRight: Radius.circular(
                        20,
                      )),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                alignment: Alignment.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 140),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(
                        20,
                      ),
                      bottomRight: Radius.circular(
                        20,
                      )),
                  color: Theme.of(context).hoverColor),
              height: 50,
              width: 140,
              child: ShimmerSkeleton(
                child: Container(width: 80, height: 20, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
