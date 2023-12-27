import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/widgets/locale_icon_direction.dart';

class EditUnitHeader extends StatelessWidget implements PreferredSizeWidget {
  const EditUnitHeader(
      {Key? key,
      this.title = "",
      this.margin = const EdgeInsetsDirectional.only(start: 24, end: 24, top: 12),
      this.endIconPath,
      this.showBackIcon = true,
      this.cancelAction,
      this.onBackAction})
      : super(key: key);

  final String title;
  final EdgeInsetsGeometry? margin;
  final String? endIconPath;
  final Function? cancelAction;
  final Function? onBackAction;
  final bool showBackIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
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
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  alignment: AlignmentDirectional.center,
                  child: Text(title))),
          Container(
              alignment: AlignmentDirectional.centerEnd,
              child: GestureDetector(
                child: Text(LocaleKeys.exit.tr()),
                onTap: () {
                  cancelAction?.call();
                },
              )),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
