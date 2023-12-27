import 'package:flutter/material.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/locale_icon_direction.dart';

import '../images.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header(
      {Key? key,
      this.title = "",
      this.margin = const EdgeInsetsDirectional.only(start: 24, end: 24, top: 12),
      this.endIconPath,
      this.showBackIcon = true,
      this.endIconAction,
      this.onBackAction})
      : super(key: key);

  final String title;
  final EdgeInsetsGeometry? margin;
  final String? endIconPath;
  final Function? endIconAction;
  final Function? onBackAction;
  final bool showBackIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              alignment: AlignmentDirectional.centerStart,
              child: SizedBox(
                width: 44,
                height: 44,
                child: showBackIcon
                    ? GestureDetector(
                        child: const LocaleIconDirection(
                          icon: backNavIconPath,
                        ),
                        onTap: () {
                          if (onBackAction != null) {
                            onBackAction?.call();
                          } else {
                            navigationKey.currentState?.pop();
                          }
                        },
                      )
                    : Container(),
              )),
          Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  alignment: AlignmentDirectional.center,
                  child: Text(title))),
          Container(
              alignment: AlignmentDirectional.centerEnd,
              child: SizedBox(
                  width: 44,
                  height: 44,
                  child: endIconPath != null
                      ? GestureDetector(
                          child: Image.asset(endIconPath!, color: kWhite),
                          onTap: () {
                            endIconAction?.call();
                          },
                        )
                      : Container())),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}