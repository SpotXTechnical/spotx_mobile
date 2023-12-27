import 'package:flutter/material.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSkeleton extends StatelessWidget {
  const ShimmerSkeleton({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: darkShimmerBase,
      highlightColor: darkShimmerHighlight,
      child: child,
    );
  }
}