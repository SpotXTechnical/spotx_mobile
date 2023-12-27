import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/swipable_button/swipable_button.dart';

/// A Button that can detect swiping movement with shimmering arrows on far end.
/// Button that swipe and increase its width to maximum
// ignore: must_be_immutable
class SwipingButton extends StatefulWidget {
  /// The text that the button will display.
  final String text;

  /// with of the button
  final double height;

  /// The callback invoked when the button is swiped.
  final VoidCallback onSwipeCallback;

  /// Optional changes
  final Color swipeButtonColor;
  final Color backgroundColor;
  final Color iconColor;
  TextStyle? buttonTextStyle;
  final EdgeInsets padding;

  /// The decimal percentage of swiping in order for the callbacks to get called, defaults to 0.75 (75%) of the total width of the children.
  final double? swipePercentageNeeded;

  SwipingButton({
    Key? key,
    required this.text,
    this.height = 60,
    required this.onSwipeCallback,
    this.swipeButtonColor = dark,
    this.backgroundColor = const Color(0x774F5BFF),
    this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.iconColor = Colors.white,
    this.buttonTextStyle,
    this.swipePercentageNeeded,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return StateSwipingButton(
        text: text,
        onSwipeCallback: onSwipeCallback,
        height: height,
        padding: padding,
        swipeButtonColor: swipeButtonColor,
        backgroundColor: backgroundColor,
        iconColor: iconColor,
        buttonTextStyle: buttonTextStyle);
  }
}

class StateSwipingButton extends State<SwipingButton> {
  /// The text that the button will display.
  final String text;
  final double height;

  /// The callback invoked when the button is swiped.
  final VoidCallback onSwipeCallback;
  bool isSwiping = false;
  double opacityVal = 1;
  final Color swipeButtonColor;
  final Color backgroundColor;
  final Color iconColor;
  TextStyle? buttonTextStyle;
  final EdgeInsets padding;

  StateSwipingButton({
    Key? key,
    required this.text,
    required this.height,
    required this.onSwipeCallback,
    this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.swipeButtonColor = Colors.amber,
    this.backgroundColor = Colors.black,
    this.iconColor = Colors.white,
    this.buttonTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    buttonTextStyle ??= avenirNextBold(color: Colors.white, fontSize: 16);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: padding,
      child: Stack(
        children: <Widget>[
          Container(
            height: height,
            decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                text.toUpperCase(),
                style: buttonTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SwipeableWidget(
            height: height,
            swipePercentageNeeded: widget.swipePercentageNeeded ?? 0.75,
            screenSize: MediaQuery.of(context).size.width - (padding.right + padding.left),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: _buildContent(),
              ),
              height: height,
              decoration: BoxDecoration(color: swipeButtonColor, borderRadius: BorderRadius.circular(8)),
            ),
            onSwipeCallback: onSwipeCallback,
            onSwipeStartcallback: (val, conVal) {
              debugPrint("isGrate $conVal");
              if (!mounted) {
                SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {
                      if (!mounted) {
                        isSwiping = val;
                        opacityVal = 1 - conVal;
                      }
                    }));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildText() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: height / 2),
      child: Text(
        text.toUpperCase(),
        style: buttonTextStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildContent() {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: <Widget>[
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: AnimatedOpacity(
            opacity: (opacityVal - 0.2).isNegative ? 0.0 : (opacityVal - 0.2),
            duration: const Duration(milliseconds: 10),
            child: Icon(
              Icons.chevron_right,
              color: iconColor,
              size: height * 0.6,
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.center,
          child: AnimatedOpacity(
            opacity: (opacityVal - 0.4).isNegative ? 0.0 : (opacityVal - 0.4),
            duration: const Duration(milliseconds: 10),
            child: Icon(
              Icons.chevron_right,
              color: iconColor,
              size: height * 0.6,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: isSwiping
              ? _buildText()
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
        )
      ],
    );
  }
}