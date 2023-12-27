import 'package:flutter/material.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/alerts/base_alert.dart';
import 'package:spotx/utils/widgets/app_button.dart';

class NormalAlert extends StatelessWidget {
  const NormalAlert({
    Key? key,
    this.title = '',
    this.body = '',
    required this.buttonTitle,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final String body;
  final String buttonTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return BaseAlert(
      title: title,
      body: body,
      buttonsWidget: AppButton(
        textWidget: Text(
          buttonTitle,
          style: circularMedium(color: kWhite, fontSize: 17),
        ),
        color: Theme.of(context).canvasColor,
        action: () {
          onPressed?.call();
        },
        title: 'hh',
      ),
    );
  }
}