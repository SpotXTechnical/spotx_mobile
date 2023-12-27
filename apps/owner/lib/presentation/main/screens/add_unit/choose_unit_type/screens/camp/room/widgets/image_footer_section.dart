import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/style/theme.dart';

class ImageSectionFooter extends StatelessWidget {
  const ImageSectionFooter({
    Key? key,
    required this.imageCount,
    required this.videoCount,
  }) : super(key: key);
  final int imageCount;
  final int videoCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 10, start: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              LocaleKeys.uploadedImages.tr() + ": $imageCount",
              style: circularMedium(color: Theme.of(context).selectedRowColor, fontSize: 12),
            ),
            flex: 1,
          ),
          Expanded(
            child: Text(
              LocaleKeys.uploadedVideos.tr() + ": $videoCount",
              style: circularMedium(color: Theme.of(context).selectedRowColor, fontSize: 12),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
