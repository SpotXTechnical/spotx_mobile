import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotx/utils/extensions/string_extensions.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';

class CustomClipRect extends StatelessWidget {
  const CustomClipRect({Key? key, this.path, required this.borderRadius, this.height, this.width}) : super(key: key);
  final String? path;
  final BorderRadiusGeometry borderRadius;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return path == null
        ? ErrorCard(
            height: height,
            borderRadius: borderRadius,
            width: width,
          )
        : ClipRRect(
            borderRadius: borderRadius,
            child: FadeInImage(
              image: CachedNetworkImageProvider(path.replaceHttps()),
              placeholder: const AssetImage(placeHolder,),
              placeholderFit: BoxFit.cover,
              imageErrorBuilder: (_, __, ___) {
                return const ErrorCard();
              },
              fit: BoxFit.cover,
              height: height,
              width: width,
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
