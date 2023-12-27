import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/utils/utils.dart';
import 'dart:math' as math;

class LocaleIconDirection extends StatelessWidget {
  const LocaleIconDirection({Key? key, required this.icon, this.boxFit}) : super(key: key);
  final String icon;
  final BoxFit? boxFit;
  @override
  Widget build(BuildContext context) {
    return isArabic
        ? Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Image.asset(
              icon,
              fit: boxFit,
            ),
          )
        : Image.asset(icon, fit: boxFit);
  }
}
