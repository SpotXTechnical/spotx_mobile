import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';

class FilterHeader extends StatelessWidget implements PreferredSizeWidget {
  const FilterHeader({Key? key, required this.resetAction}) : super(key: key);

  final Function resetAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 18, end: 10),
      child: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.filter.tr()),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: GestureDetector(
          child: Image.asset(closeWithBoxIconPath, color: kWhite),
          onTap: () {
            navigationKey.currentState?.pop();
          },
        ),
        actions: [
          GestureDetector(
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.reset.tr(),
                style: circularMedium(color: kWhite, fontSize: 17),
              ),
            ),
            onTap: () {
              resetAction.call();
            },
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}