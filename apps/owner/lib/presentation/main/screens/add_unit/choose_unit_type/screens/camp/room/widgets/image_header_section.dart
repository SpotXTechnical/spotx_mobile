import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/style/theme.dart';

class ImageSectionHeaderWidget extends StatelessWidget {
  const ImageSectionHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              LocaleKeys.uploadImagesAndVideos.tr(),
              style: circularMedium(color: Theme.of(context).hintColor, fontSize: 14),
              overflow: TextOverflow.fade,
            ),
            flex: 1,
          ),
          Expanded(
            flex: 1,
            child: Text(
              LocaleKeys.upTo10ImagesAndOneVideo.tr(),
              style: circularMedium(color: Theme.of(context).primaryColorLight, fontSize: 12),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
      margin: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
    );
  }
}
