import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, this.color, this.strokeWith = 4.0}) : super(key: key);

  final Color? color;
  final double strokeWith;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color ?? Theme.of(context).primaryColorLight),
        strokeWidth: strokeWith,
      ),
    );
  }
}
