import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/utils.dart';
import 'dart:math' as math;

class LocaleIconDirection extends StatelessWidget {
  const LocaleIconDirection({Key? key, required this.icon}) : super(key: key);
  final String icon;
  @override
  Widget build(BuildContext context) {
    return isArabic
        ? Transform.rotate(
            angle: -math.pi,
            child: Image.asset(icon, color: kWhite),
          )
        : Image.asset(icon, color: kWhite);
  }
}