import 'package:spotx/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/alerts/base_alert.dart';
import 'package:spotx/utils/widgets/app_button.dart';

class ConfirmationAlert extends StatelessWidget {
  const ConfirmationAlert({
    Key? key,
    this.title = '',
    this.body = '',
    required this.confirmButtonTitle,
    required this.cancelButtonTitle,
    this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  final String title;
  final String body;
  final String confirmButtonTitle;
  final String cancelButtonTitle;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return BaseAlert(
      title: title,
      body: body,
      buttonsWidget: Row(
        children: <Widget>[
          Expanded(
            child: AppButton(
              textWidget: Text(
                confirmButtonTitle,
                style: circularMedium(color: kWhite, fontSize: 17),
              ),
              title: confirmButtonTitle,
              color: kWhite,
              padding: const EdgeInsets.symmetric(vertical: 10),
              action: () {
                context.navigator.pop(true);
                onConfirm?.call();
              },
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: AppButton(
              textWidget: Text(
                cancelButtonTitle,
                style: circularMedium(color: kWhite, fontSize: 17),
              ),
              title: cancelButtonTitle,
              color: kWhite,
              padding: const EdgeInsets.symmetric(vertical: 10),
              textColor: kWhite,
              action: () {
                context.navigator.pop(false);
                onCancel?.call();
              },
            ),
          ),
        ],
      ),
    );
  }
}