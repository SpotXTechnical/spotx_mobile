import 'package:flutter/material.dart';
import 'package:owner/presentation/main/screens/home/widget/home_unit_card_shimmer.dart';

class HomeUnitsLoadingWidget extends StatelessWidget {
  const HomeUnitsLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 24, end: 24, bottom: 20, top: 8),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return const Divider(indent: 20);
        },
        itemBuilder: (BuildContext context, int index) => const HomeUnitCardShimmer(),
      ),
    );
  }
}
