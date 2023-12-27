import 'package:flutter/material.dart';
import 'package:spotx/utils/widgets/shimmer_skeleton.dart';

class UnitCardShimmer extends StatelessWidget {
  const UnitCardShimmer({Key? key, required this.width}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).hoverColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerSkeleton(
              child: Container(
                width: width,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                alignment: Alignment.center,
              ),
            ),
            ShimmerSkeleton(
              child: Container(
                margin: const EdgeInsetsDirectional.only(top: 8, start: 5),
                height: 20,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            ShimmerSkeleton(
              child: Container(
                margin: const EdgeInsetsDirectional.only(top: 8, start: 5),
                height: 20,
                width: 180,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            ShimmerSkeleton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      height: 30,
                      width: 40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      margin: const EdgeInsetsDirectional.only(start: 5),
                      height: 30,
                      width: 40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      margin: const EdgeInsetsDirectional.only(start: 5),
                      height: 30,
                      width: 60,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      margin: const EdgeInsetsDirectional.only(start: 5),
                      height: 30,
                      width: 60,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
