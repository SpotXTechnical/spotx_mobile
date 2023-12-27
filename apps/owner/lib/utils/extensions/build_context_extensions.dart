import 'package:owner/utils/widgets/alerts/confirmation_alert.dart';
import 'package:owner/utils/widgets/alerts/multi_select_alert.dart';
import 'package:owner/utils/widgets/alerts/normal_alert.dart';
import 'package:owner/utils/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

extension BuildContextExtensions on BuildContext {
  FocusScopeNode get focusScope => FocusScope.of(this);
  ScaffoldState get scaffold => Scaffold.of(this);
  ThemeData get theme => Theme.of(this);
  NavigatorState get navigator => Navigator.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  TextDirection get textDirection => Directionality.of(this);
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}

extension ScaffoldExtensions on BuildContext {
  void showSnackBar(
    String message, {
    EdgeInsetsGeometry padding = EdgeInsets.zero,
  }) {
    focusScope.requestFocus(FocusNode());
    scaffoldMessenger
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Padding(
        padding: padding,
        child: Text(message),
      )));
  }

  Future<T?> showAppModalBottomSheet<T>({
    required Widget child,
    EdgeInsets? padding,
    Color backgroundColor = Colors.white,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    RouteSettings? routeSettings,
    double borderRadius = 26.5,
  }) {
    assert(debugCheckHasMediaQuery(this));
    assert(debugCheckHasMaterialLocalizations(this));

    return showModalBottomSheet(
        context: this,
        backgroundColor: Colors.transparent,
        isScrollControlled: isScrollControlled,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        isDismissible: isDismissible,
        barrierColor: barrierColor,
        enableDrag: enableDrag,
        routeSettings: routeSettings,
        builder: (BuildContext context) {
          return Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
            ),
            child: child,
          );
        });
  }
}

extension NavigatorStateExtensions on NavigatorState {
  Future<T?> pushNamedAndRemoveAll<T extends Object>(
    String newRouteName, {
    Object? arguments,
  }) =>
      pushNamedAndRemoveUntil(newRouteName, (Route<dynamic> route) => false, arguments: arguments);
}

extension DialogExtensions on BuildContext {
  Future<LoadingWidget?> showLoadingDialog() => showDialog<LoadingWidget>(
        context: this,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const LoadingWidget();
        },
      );

  Future<bool?> showNormalAlert({
    String title = '',
    String body = '',
    String buttonTitle = '',
    VoidCallback? onPressed,
    VoidCallback? onDismiss,
    bool isDismissible = true,
  }) async {
    final bool? result = await showDialog<bool>(
      context: this,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: isDismissible,
      builder: (BuildContext context) => NormalAlert(
        title: title,
        body: body,
        buttonTitle: buttonTitle,
        onPressed: onPressed,
      ),
    );
    if (result == null) {
      onDismiss?.call();
    }
    return result;
  }

  Future<bool?> showConfirmationAlert({
    required String title,
    required String body,
    required String confirmButtonTitle,
    required String cancelButtonTitle,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    VoidCallback? onDismiss,
    bool isDismissible = true,
  }) async {
    final bool? result = await showDialog<bool>(
      context: this,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: isDismissible,
      builder: (BuildContext context) => ConfirmationAlert(
        title: title,
        body: body,
        confirmButtonTitle: confirmButtonTitle,
        cancelButtonTitle: cancelButtonTitle,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
    if (result == null) {
      onDismiss?.call();
    }
    return result;
  }

  Future<bool?> showMultiSelectDialog(
      {required String title,
      required String body,
      bool isDismissible = true,
      required Map<String, VoidCallback> actions}) async {
    final bool? result = await showDialog<bool>(
      context: this,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierDismissible: isDismissible,
      builder: (BuildContext context) => MultiSelectAlert(
        title: title,
        body: body,
        actions: actions,
      ),
    );
    return result;
  }
}

extension FocusScopeNodeExtensions on FocusScopeNode {
  void tryUnfocus() {
    if (!hasPrimaryFocus) {
      unfocus();
    }
  }
}

extension FarisiNumbers on int? {
  String replaceFarsiNumber() {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '٤', '۵', '٦', '۷', '۸', '۹'];
    String outPut = toString();
    if (isArabic) {
      for (int i = 0; i < english.length; i++) {
        outPut = outPut.replaceAll(english[i], farsi[i]);
      }
    }
    return outPut;
  }
}
