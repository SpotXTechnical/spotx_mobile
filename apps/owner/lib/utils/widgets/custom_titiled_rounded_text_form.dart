import 'package:flutter/material.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/CustomRoundedTextFormField.dart';

class CustomTitledRoundedTextFormWidget extends StatefulWidget {
  final String? hintText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final bool? obscureText;
  final bool? isEmail;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final bool? autoFocus;
  final Color? fillColor;
  final TextDirection? textDirection;
  final InputDecoration? decoration;
  final bool? hidePassword;
  final String? title;
  final String? sideTitle;
  final Image? icon;
  final Image? suffixIcon;
  final String? labelText;
  final int maxLines;
  final int minLines;
  final Function? suffixIconCallBack;
  final TextStyle? textStyle;
  final bool enabled;
  final ValueChanged<String>? onChanged;

  const CustomTitledRoundedTextFormWidget(
      {Key? key,
      this.hintText,
      this.validator,
      this.onFieldSubmitted,
      this.obscureText = false,
      this.isEmail,
      this.keyboardType,
      this.controller,
      this.focusNode,
      this.textInputAction,
      this.prefixIcon,
      this.autoFocus,
      this.fillColor,
      this.suffixIcon,
      this.suffixIconCallBack,
      this.textDirection,
      this.decoration = const InputDecoration(),
      this.hidePassword = false,
      this.enabled = true,
      this.title,
      this.icon,
      this.maxLines = 1,
      this.minLines = 1,
      this.labelText,
      this.textStyle,
      this.sideTitle,
      this.onChanged})
      : super(key: key);
  @override
  _CustomTitledRoundedTextFormWidgetState createState() => _CustomTitledRoundedTextFormWidgetState();
}

class _CustomTitledRoundedTextFormWidgetState extends State<CustomTitledRoundedTextFormWidget> {
  bool? hidePassword;
  @override
  void initState() {
    super.initState();
    hidePassword = widget.hidePassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.title}",
                  style: circularBook(color: kWhite, fontSize: 17),
                ),
                if (widget.sideTitle != null)
                  Text(
                    "${widget.sideTitle}",
                    style: circularBook(color: Theme.of(context).selectedRowColor, fontSize: 13),
                  ),
              ],
            ),
          ),
          CustomRoundedTextFormField(
            suffixIconCallBack: widget.suffixIconCallBack,
            suffixIcon: widget.suffixIcon,
            labelText: widget.labelText,
            maxLines: widget.maxLines,
            minLines: widget.maxLines,
            hidePassword: hidePassword,
            controller: widget.controller,
            validator: widget.validator,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onFieldSubmitted,
            hasBorder: true,
            enabled: widget.enabled,
            hintText: widget.hintText,
            cursorColor: kWhite,
            style: widget.textStyle ?? const TextStyle(color: kWhite),
            onChanged: widget.onChanged,
            autoFocus: widget.autoFocus,
          ),
        ],
      ),
    );
  }
}