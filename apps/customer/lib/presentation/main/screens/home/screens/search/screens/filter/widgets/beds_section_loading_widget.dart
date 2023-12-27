import 'package:flutter/material.dart';
import 'package:spotx/utils/widgets/shimmer_skeleton.dart';

class BedsSectionLoadingWidget extends StatelessWidget {
  const BedsSectionLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 20, start: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerSkeleton(
            child: Container(
              width: 60,
              height: 25,
              color: Theme.of(context).hoverColor,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 11),
            child: ShimmerSkeleton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).hoverColor,
                    ),
                    height: 30,
                    width: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).hoverColor,
                    ),
                    margin: const EdgeInsetsDirectional.only(start: 5),
                    height: 30,
                    width: 35,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).hoverColor,
                    ),
                    margin: const EdgeInsetsDirectional.only(start: 5),
                    height: 30,
                    width: 35,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).hoverColor,
                    ),
                    margin: const EdgeInsetsDirectional.only(start: 5),
                    height: 30,
                    width: 35,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).hoverColor,
                    ),
                    margin: const EdgeInsetsDirectional.only(start: 5),
                    height: 30,
                    width: 35,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).hoverColor,
                    ),
                    margin: const EdgeInsetsDirectional.only(start: 5),
                    height: 30,
                    width: 35,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Theme.of(context).hoverColor,
                    ),
                    margin: const EdgeInsetsDirectional.only(start: 5),
                    height: 30,
                    width: 35,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
