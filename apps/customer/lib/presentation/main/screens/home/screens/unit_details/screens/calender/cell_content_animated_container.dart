import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/utils/style/theme.dart';

const duration = Duration(milliseconds: 250);

class CellContentAnimatedContainer extends StatelessWidget {
  const CellContentAnimatedContainer({Key? key, required this.cellDecoration, required this.day, required this.price, required this.textStyle})
      : super(key: key);
  final Decoration cellDecoration;
  final int day;
  final int price;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: duration,
        margin: const EdgeInsets.all(0.0),
        padding: const EdgeInsets.all(0.0),
        decoration: cellDecoration,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(day.toString(), style: textStyle),
              Text(price.toString(), style: circularBook(color: kWhite, fontSize: 9)),
            ],
          ),
        ));
  }
}