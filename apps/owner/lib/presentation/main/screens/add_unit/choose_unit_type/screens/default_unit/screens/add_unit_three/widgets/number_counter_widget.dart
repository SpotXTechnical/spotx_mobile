import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';

class NumbersCounter extends StatelessWidget {
  const NumbersCounter({Key? key, required this.incrementNumber, required this.decrementNumber, required this.number, required this.title})
      : super(key: key);
  final Function incrementNumber;
  final Function decrementNumber;
  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 20, start: 23, end: 23),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: circularBook(color: kWhite, fontSize: 17),
          ),
          Row(
            children: [
              GestureDetector(
                child: Image.asset(minusIconPath),
                onTap: () {
                  if (number > 1) {
                    decrementNumber.call();
                  }
                },
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  number.toString(),
                  style: circularBook(color: kWhite, fontSize: 17),
                ),
              ),
              GestureDetector(
                child: Image.asset(plusIconPath,),
                onTap: () {
                  incrementNumber.call();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}