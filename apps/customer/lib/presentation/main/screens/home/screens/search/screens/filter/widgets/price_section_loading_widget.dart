import 'package:flutter/material.dart';
import 'package:spotx/utils/widgets/shimmer_skeleton.dart';

class PriceSectionLoadingWidget extends StatelessWidget {
  const PriceSectionLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 20, start: 23, end: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerSkeleton(
            child: Container(
              width: 50,
              height: 25,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          ShimmerSkeleton(
              child: Column(
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(top: 11),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                height: 40,
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(top: 11),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                height: 40,
              ),
            ],
          )),
          Padding(
            padding: const EdgeInsets.only(top: 11.0),
            child: ShimmerSkeleton(
                child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 10,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  height: 25,
                  width: 25,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    height: 25,
                    width: 25,
                  ),
                ),
              ],
            )),
          )
        ],
      ),
    );
  }
}
