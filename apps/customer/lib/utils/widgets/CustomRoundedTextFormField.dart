import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/utils.dart';

import '../images.dart';

class CustomRoundedTextFormField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final bool? obscureText;
  final bool? isEmail;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? icon;
  final Widget? suffixIcon;
  final bool? autoFocus;
  final Color? fillColor;
  final TextDirection? textDirection;
  final int? minLines;
  final int? maxLines;
  final bool? hasBorder;
  final Color? cursorColor;
  final bool? hidePassword;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;
  final double? radius;
  final EdgeInsets? padding;
  final bool? enabled;
  final TextStyle? hintStyle;

  const CustomRoundedTextFormField(
      {Key? key,
      this.hintText,
      this.labelText,
      this.validator,
      this.onFieldSubmitted,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.focusNode,
      this.textInputAction,
      this.obscureText = false,
      this.isEmail = false,
      this.icon,
      this.prefixIcon,
      this.suffixIcon,
      this.autoFocus = false,
      this.fillColor,
      this.textDirection = TextDirection.ltr,
      this.onChanged,
      this.maxLines,
      this.minLines,
      this.inputFormatters,
      this.cursorColor,
      this.hidePassword = false,
      this.style,
      this.radius = 15,
      this.enabled,
      this.padding = const EdgeInsets.all(15),
      this.hasBorder = false,
      this.hintStyle})
      : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomRoundedTextFormField> {
  bool? hidePassword;
  @override
  void initState() {
    super.initState();
    hidePassword = widget.hidePassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        inputFormatters: widget.inputFormatters,
        maxLines: widget.maxLines,
        autofocus: widget.autoFocus ?? false,
        obscureText: (widget.obscureText ?? false) && hidePassword!,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        focusNode: widget.focusNode,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        minLines: widget.minLines,
        cursorColor: widget.cursorColor,
        style: widget.style,
        enabled: widget.enabled ?? true,
        decoration: InputDecoration(
          hintStyle: widget.hintStyle ?? circularMedium(color: Theme.of(context).unselectedWidgetColor, fontSize: 14),
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
              : widget.suffixIcon,
          fillColor: widget.fillColor ?? Theme.of(context).scaffoldBackgroundColor,
          filled: true,
          hintText: widget.hintText,
          isDense: true,
          labelText: widget.labelText,
          labelStyle: TextStyle(color: kWhite),
          contentPadding: widget.padding,
          prefixIcon: widget.prefixIcon,
          icon: widget.icon,
          errorStyle: errorTextStyle,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius!),
              borderSide: BorderSide(
                  color: cadetGrey,
                  width: .5,
                  style: (widget.hasBorder ?? false) ? BorderStyle.solid : BorderStyle.none)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius!),
              borderSide: BorderSide(
                  color: cadetGrey,
                  width: .5,
                  style: (widget.hasBorder ?? false) ? BorderStyle.solid : BorderStyle.none)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius!),
              borderSide: BorderSide(
                  color: kWhite,
                  width: .5,
                  style: (widget.hasBorder ?? false) ? BorderStyle.solid : BorderStyle.none)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius!),
              borderSide: BorderSide(
                  color: Theme.of(context).splashColor,
                  width: .5,
                  style: (widget.hasBorder ?? false) ? BorderStyle.solid : BorderStyle.none)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius!),
              borderSide: BorderSide(
                  color: Theme.of(context).splashColor,
                  width: .5,
                  style: (widget.hasBorder ?? false) ? BorderStyle.solid : BorderStyle.none)),
        ));
  }
}