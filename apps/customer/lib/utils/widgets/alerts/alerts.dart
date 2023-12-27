import 'package:flutter/cupertino.dart';
import 'package:spotx/utils/extensions/build_context_extensions.dart';

export 'confirmation_alert.dart';
export 'normal_alert.dart';

void showOneButtonAlert(
  BuildContext context, {
  String title = '',
  String body = '',
  String buttonTitle = '',
  VoidCallback? onPressed,
  bool isDismissible = true,
}) {
  context.showImageAlert(
      isDismissible: isDismissible, title: title, body: body, buttonTitle: buttonTitle, onPressed: onPressed);
}
