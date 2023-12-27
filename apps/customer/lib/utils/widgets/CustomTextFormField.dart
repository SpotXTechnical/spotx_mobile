import 'package:flutter/material.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';

class CustomTextFormField extends StatefulWidget {
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
  final TextStyle? hintStyle;
  final bool? hidePassword;

  const CustomTextFormField({
    Key? key,
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
    this.hintStyle,
    this.decoration = const InputDecoration(),
    this.hidePassword = false,
  }) : super(key: key);
  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool? hidePassword;
  @override
  void initState() {
    super.initState();
    hidePassword = widget.hidePassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: hidePassword!,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(color: kWhite),
      cursorColor: kWhite,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).disabledColor),
        ),
        errorStyle: errorTextStyle,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        suffixIcon: (widget.obscureText ?? false)
            ? GestureDetector(
                child: hidePassword!
                    ? Image.asset(showPasswordIconPath, color: kWhite)
                    : Image.asset(hidePasswordIconPath, color: kWhite),
                onTap: () {
                  setState(() {
                    hidePassword = !hidePassword!;
                  });
                },
              )
            : null,
      ),
    );
  }
}