import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({Key? key, this.backgroundColor = Colors.white, this.radius = 22, required this.child})
      : super(key: key);
  final Color backgroundColor;
  final double radius;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      radius: radius,
      child: child,
    );
  }
}
