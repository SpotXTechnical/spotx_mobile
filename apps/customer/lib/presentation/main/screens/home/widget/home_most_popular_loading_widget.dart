import 'package:flutter/material.dart';
import 'package:spotx/presentation/main/screens/home/widget/shimmer/home_unit_card_shimmer.dart';

class UnitsLoadingWidget extends StatelessWidget {
  const UnitsLoadingWidget({Key? key, this.scrollDirection, this.height, required this.cardWidth}) : super(key: key);
  final Axis? scrollDirection;
  final double? height;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 270,
      margin: const EdgeInsetsDirectional.only(top: 17),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        scrollDirection: scrollDirection ?? Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return const Divider(
            indent: 15,
          );
        },
        itemBuilder: (BuildContext context, int index) => UnitCardShimmer(
          width: cardWidth,
        ),
      ),
    );
  }
}
