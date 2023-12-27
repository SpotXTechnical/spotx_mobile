import 'package:flutter/material.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/alerts/base_alert.dart';
import 'package:owner/utils/widgets/app_buttons/gradientAppButton.dart';

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
      buttonsWidget: AppButtonGradient(
        textWidget: Text(buttonTitle, style: circularMedium(color: kWhite, fontSize: 17)),
        title: buttonTitle,
        color: Theme.of(context).scaffoldBackgroundColor,
        action: () {
          onPressed?.call();
        },
      ),
    );
  }
}