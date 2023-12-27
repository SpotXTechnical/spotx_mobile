import 'package:flutter/material.dart';
import 'package:spotx/utils/style/theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, this.color = pacificBlue, this.strokeWith = 4.0}) : super(key: key);

  final Color color;
  final double strokeWith;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: strokeWith,
      ),
    );
  }
}
