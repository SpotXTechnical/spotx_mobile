import 'package:flutter/material.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';

class BaseImageAlert extends StatelessWidget {
  const BaseImageAlert({
    Key? key,
    this.title = '',
    this.body = '',
    this.buttonsWidget,
  }) : super(key: key);

  final String title;
  final String body;
  final Widget? buttonsWidget;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          padding: const EdgeInsetsDirectional.only(
            top: 36,
            bottom: 14,
            end: 13,
            start: 13,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(finishReservation),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  body,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: kWhite,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              buttonsWidget ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}