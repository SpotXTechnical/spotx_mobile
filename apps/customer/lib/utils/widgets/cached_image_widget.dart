import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:spotx/utils/extensions/string_extensions.dart';
import 'package:spotx/utils/images.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    Key? key,
    required this.imageUrl,
    required this.placeholder,
    required this.fit,
  }) : super(key: key);

  final String imageUrl;
  final String placeholder;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      image: CachedNetworkImageProvider(imageUrl.replaceHttps()),
      placeholder: const AssetImage(placeHolder,),
      imageErrorBuilder: (_, __, ___) {
        return Image.asset(placeholder);
      },
      fit: BoxFit.fill,
    );
  }
}
