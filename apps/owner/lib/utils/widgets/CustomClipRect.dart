import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:owner/utils/extensions/string_extensions.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';

class CustomClipRect extends StatelessWidget {
  const CustomClipRect({Key? key, this.path, required this.borderRadius, this.height, this.width, this.errorWidget})
      : super(key: key);
  final String? path;
  final BorderRadiusGeometry borderRadius;
  final double? height;
  final double? width;
  final Widget? errorWidget;
  @override
  Widget build(BuildContext context) {
    return path == null
        ? errorWidget ??
            ErrorCard(
              height: height,
              borderRadius: borderRadius,
              width: width,
            )
        : ClipRRect(
            borderRadius: borderRadius,
            child: CachedNetworkImage(
              placeholder: (context, url) => Image.asset(
                placeHolder,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => const ErrorCard(),
              fit: BoxFit.cover,
              height: height,
              width: width,
              imageUrl: path.replaceHttps(),
            ),
          );
  }
}

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    Key? key,
    this.height,
    this.borderRadius,
    this.width,
  }) : super(key: key);

  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: imageErrorColor,
      ),
      child: const Center(
        child: Icon(CupertinoIcons.photo),
      ),
    );
  }
}
