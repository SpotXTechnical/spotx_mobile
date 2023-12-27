import 'package:flutter/material.dart';
import 'package:owner/utils/widgets/app_buttons/app_button.dart';
import 'package:owner/utils/widgets/shimmer_skeleton.dart';

class SubRegionsSectionLoadingWidget extends StatelessWidget {
  const SubRegionsSectionLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerSkeleton(
          child: Container(
            margin: const EdgeInsetsDirectional.only(start: 23),
            width: 60,
            height: 25,
            color: Colors.grey.shade200,
          ),
        ),
        Container(
            margin: const EdgeInsetsDirectional.only(start: 23, end: 23),
            child: const ShimmerSkeleton(
                child: AppButton(title: "",)
            )
        ),
      ],
    );
  }
}
