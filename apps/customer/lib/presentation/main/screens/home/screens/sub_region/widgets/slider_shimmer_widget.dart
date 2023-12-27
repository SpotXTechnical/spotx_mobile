import 'package:flutter/material.dart';
import 'package:spotx/utils/widgets/shimmer_skeleton.dart';

class SliderShimmerWidget extends StatelessWidget {
  const SliderShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerSkeleton(
      child: Container(
        margin: const EdgeInsetsDirectional.only(top: 17, start: 24, end: 24),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).hoverColor,
        ),
        height: 200,
      ),
    );
  }
}