import 'package:flutter/material.dart';
import 'package:spotx/utils/navigation/navigation_helper.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/locale_icon_direction.dart';

import '../images.dart';

class Header extends StatelessWidget {
  const Header({Key? key, this.title = "", this.endIconPath, this.showBackIcon = true, this.endIconAction, this.onBackAction})
      : super(key: key);

  final String title;
  final String? endIconPath;
  final Function? endIconAction;
  final bool showBackIcon;
  final Function? onBackAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              alignment: AlignmentDirectional.centerStart,
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
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                alignment: AlignmentDirectional.center,
                child: Text(
                  title,
                  style: circularMedium(color: kWhite, fontSize: 20),
                )),
          ),
          Expanded(
            child: Container(
              alignment: AlignmentDirectional.centerEnd,
              child: endIconPath != null
                  ? InkWell(
                      splashColor: Colors.transparent,
                      child: SizedBox(
                          width: 44,
                          height: 44,
                          child: Image.asset(endIconPath!, color: kWhite)),
                      onTap: () {
                        endIconAction?.call();
                      },
                    )
                  : Container(),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}