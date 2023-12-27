import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/utils/style/theme.dart';

const duration = Duration(milliseconds: 250);

class CellContentAnimatedContainer extends StatelessWidget {
  const CellContentAnimatedContainer({
    Key? key,
    required this.cellDecoration,
    required this.day,
    required this.price,
    required this.textStyle,
    this.hasStartSpace = false,
    this.hasEndSpace = false,
    this.isReserved = false,
  }) : super(key: key);
  final Decoration cellDecoration;
  final int day;
  final String price;
  final TextStyle textStyle;
  final bool hasStartSpace;
  final bool hasEndSpace;
  final bool isReserved;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: duration,
        margin: EdgeInsetsDirectional.only(
          end: hasEndSpace ? 1.0 : 0,
          start: hasStartSpace ? 1.0 : 0.0,
          top: isReserved ? 1.0 : 0.0,
          bottom: isReserved ? 1.0 : 0.0,
        ),
        padding: const EdgeInsets.all(0.0),
        decoration: cellDecoration,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(day.toString(), style: textStyle),
                Text(price.toString(), style: circularBook(color: kWhite, fontSize: 9)),
              ],
            ),
          ),
        ));
  }
}