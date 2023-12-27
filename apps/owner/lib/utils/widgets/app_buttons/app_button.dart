import 'package:flutter/material.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key,
      required this.title,
      this.action,
      this.height,
      this.width,
      this.enabled = true,
      this.isLoading = false,
      this.color,
      this.disabledColor,
      this.borderRadius = const BorderRadiusDirectional.all(Radius.circular(10)),
      this.borderColor = Colors.transparent,
      this.textColor = Colors.white,
      this.textWidget,
      this.boxDecoration,
      this.padding,
      this.backGround})
      : super(key: key);

  final String title;
  final VoidCallback? action;
  final double? height;
  final double? width;
  final bool enabled;
  final bool isLoading;
  final Color? color;
  final Color? disabledColor;
  final BorderRadiusDirectional borderRadius;
  final Color borderColor;
  final Color textColor;
  final Widget? textWidget;
  final BoxDecoration? boxDecoration;
  final EdgeInsets? padding;
  final Color? backGround;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: boxDecoration,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: padding ?? const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: borderColor),
                  borderRadius: borderRadius,
                ),
                primary: backGround != null
                    ? backGround
                    : enabled
                        ? Theme.of(context).primaryColorLight
                        : disabledColor ?? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
              ),
              onPressed: () {
                if (!isLoading && enabled && action != null) {
                  action?.call();
                }
              },
              child: isLoading ? Container() : Center(child: textWidget)),
          SizedBox(
            height: 15,
            width: 15,
            child: isLoading ? const LoadingWidget(color: Colors.white) : Container(),
          )
        ],
      ),
    );
  }
}
