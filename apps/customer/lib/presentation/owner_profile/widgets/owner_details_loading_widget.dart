import 'package:flutter/material.dart';
import 'package:spotx/utils/widgets/CustomClipRect.dart';
import 'package:spotx/utils/widgets/shimmer_skeleton.dart';

class OwnerDetailsLoadingWidget extends StatelessWidget {
  const OwnerDetailsLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 12, start: 24, end: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShimmerSkeleton(
            child: Container(
              decoration: const BoxDecoration(),
              child: const CustomClipRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                width: 48,
                height: 48,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ShimmerSkeleton(
            child: Container(
              color: Theme.of(context).hoverColor,
              width: 100,
              height: 25,
            ),
          ),
        ],
      ),
    );
  }
}