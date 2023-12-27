import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/utils/images.dart';

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
          margin: const EdgeInsets.only(top: 71),
          alignment: Alignment.topLeft,
          child: Image.asset(loginDecoration1Path,),
        ),
        Image.asset(loginDecoration2Path, fit: BoxFit.cover,),
      ],
    );
  }
}
