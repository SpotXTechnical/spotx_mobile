import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/CustomRoundedTextFormField.dart';

class RegisterInputWidget extends StatefulWidget {
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
  final Image? icon;
  final String? labelText;
  final bool? enabled;

  const RegisterInputWidget(
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
      this.textDirection,
      this.decoration = const InputDecoration(),
      this.hidePassword = false,
      this.title,
      this.icon,
      this.labelText,
      this.enabled})
      : super(key: key);
  @override
  _RegisterInputWidgetState createState() => _RegisterInputWidgetState();
}

class _RegisterInputWidgetState extends State<RegisterInputWidget> {
  bool? hidePassword;
  @override
  void initState() {
    super.initState();
    hidePassword = widget.hidePassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "${widget.title}",
              style: circularMedium(color: kWhite, fontSize: 14),
            ),
            margin: const EdgeInsetsDirectional.only(bottom: 10),
          ),
          CustomRoundedTextFormField(
            labelText: widget.labelText,
            maxLines: 1,
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
            style: TextStyle(color: kWhite),
          ),
        ],
      ),
    );
  }
}