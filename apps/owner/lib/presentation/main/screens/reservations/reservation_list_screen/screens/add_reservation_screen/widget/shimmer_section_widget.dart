import 'package:flutter/material.dart';
import 'package:owner/utils/widgets/shimmer_skeleton.dart';

class ShimmerSectionWidget extends StatelessWidget {
  const ShimmerSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerSkeleton(
          child: Container(
            height: 20,
            width: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).hoverColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ShimmerSkeleton(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).hoverColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}