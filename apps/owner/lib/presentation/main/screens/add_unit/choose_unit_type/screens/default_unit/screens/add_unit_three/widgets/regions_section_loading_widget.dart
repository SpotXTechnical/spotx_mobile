import 'package:flutter/material.dart';
import 'package:owner/utils/widgets/shimmer_skeleton.dart';

class RegionsSectionLoadingWidget extends StatelessWidget {
  const RegionsSectionLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerSkeleton(
            child: Container(
              width: 60,
              height: 25,
              color: Colors.grey.shade200,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 11),
            child: ShimmerSkeleton(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey.shade200,
                      ),
                      height: 30,
                      width: 90,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey.shade200,
                      ),
                      margin: const EdgeInsetsDirectional.only(start: 5),
                      height: 30,
                      width: 90,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey.shade200,
                      ),
                      margin: const EdgeInsetsDirectional.only(start: 5),
                      height: 30,
                      width: 90,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey.shade200,
                      ),
                      margin: const EdgeInsetsDirectional.only(start: 5),
                      height: 30,
                      width: 90,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey.shade200,
                      ),
                      margin: const EdgeInsetsDirectional.only(start: 5),
                      height: 30,
                      width: 90,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
