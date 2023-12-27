import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/widgets/locale_icon_direction.dart';

class LoginDecorationWidget extends StatelessWidget {
  const LoginDecorationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsetsDirectional.only(top: 71),
          alignment: Alignment.topLeft,
          child: Image.asset(loginDecoration1Path,),
        ),
        const LocaleIconDirection(
          icon: loginDecoration2Path,
          boxFit: BoxFit.cover,
        )
      ],
    );
  }
}
