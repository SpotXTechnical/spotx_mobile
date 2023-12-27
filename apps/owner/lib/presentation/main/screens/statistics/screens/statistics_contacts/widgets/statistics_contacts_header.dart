import 'package:flutter/material.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';

class StatisticsContactsHeader extends StatelessWidget {
  const StatisticsContactsHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              width: 44,
              height: 44,
              child: Image.asset(backNavIconPath, color: kWhite),
            ),
            onTap: () {
              navigationKey.currentState?.pop();
            },
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Theme.of(context).disabledColor)),
            width: 44,
            height: 44,
            child: Image.asset(filterIconPath, color: kWhite),
          ),
        ],
      ),
    );
  }
}