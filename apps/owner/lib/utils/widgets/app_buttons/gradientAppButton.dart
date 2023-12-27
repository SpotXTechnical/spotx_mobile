import 'package:flutter/material.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/loading_widget.dart';

class AppButtonGradient extends StatelessWidget {
  const AppButtonGradient(
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
      this.textColor,
      this.textWidget,
      this.boxDecoration,
      this.padding})
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
  final Color? textColor;
  final Widget? textWidget;
  final BoxDecoration? boxDecoration;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: boxDecoration,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                ),
                borderRadius: borderRadius,
                gradient: LinearGradient(colors: [
                  enabled? Theme.of(context).primaryColorLight: dimGrey,
                  enabled? Theme.of(context).highlightColor: cadetGrey,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Material(
              color: Colors.transparent,
              borderRadius: borderRadius,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: kWhite.withOpacity(0.3),
                child: Padding(
                    padding: padding ?? const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor,
                        ),
                      ),
                      child: isLoading
                          ? Container()
                          : Center(
                              child: textWidget,
                            ),
                    )),
                onTap: () {
                  if (!isLoading && enabled && action != null) {
                    action?.call();
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 15,
            width: 15,
            child: isLoading ? LoadingWidget(color: kWhite) : Container(),
          )
        ],
      ),
    );
  }
}