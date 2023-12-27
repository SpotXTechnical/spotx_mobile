import 'package:flutter/material.dart';

class OmnifulImage extends StatelessWidget {
  const OmnifulImage({
    Key? key,
    required this.url,
    this.width = 28,
    this.height = 28,
    this.fit =  BoxFit.fitHeight,
  }) : super(key: key);

  final String? url;
  final double width;
  final double height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      return Image.network(
        url??'',
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (BuildContext context, _, __) {
          return _getDefaultImage();
        },
      );
    } else {
      return _getDefaultImage();
    }
  }

  Widget _getDefaultImage() => Image.asset(
        'assets/images/placeholder.png',
        // color: cornflowerBlue,
        width: width,
        height: height,
      );
}
