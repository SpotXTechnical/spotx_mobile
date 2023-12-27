import 'package:flutter/material.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';

class StatisticsHeader extends StatelessWidget {
  const StatisticsHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.green,
            ),
            width: 44,
            height: 44,
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Theme.of(context).disabledColor)),
            width: 44,
            height: 44,
            child: Image.asset(notificationIconPath, color: kWhite),
          ),
        ],
      ),
    );
  }
}