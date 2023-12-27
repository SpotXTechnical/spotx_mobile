import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';

import '../../../../../../../../../utils/widgets/locale_icon_direction.dart';

class FilterScreenHeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const FilterScreenHeaderWidget({
    Key? key,
    required this.resetAction,
  }) : super(key: key);
  final Function resetAction;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: AlignmentDirectional.centerStart,
              child: GestureDetector(
                child: const LocaleIconDirection(
                  icon: backNavIconPath,
                ),
                onTap: () {
                  navigationKey.currentState?.pop();
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: AlignmentDirectional.center,
              child: Text(
                LocaleKeys.filter.tr(),
                style: circularMedium(color: kWhite, fontSize: 17),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: AlignmentDirectional.centerEnd,
              child: GestureDetector(
                child: Text(LocaleKeys.reset.tr(), style: circularMedium(color: kWhite, fontSize: 17)),
                onTap: () {
                  resetAction.call();
                },
              ),
            ),
          )
          // Your widgets here
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}