import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:spotx/data/remote/unit/model/image_entity.dart';
import 'package:spotx/generated/locale_keys.g.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/CustomClipRect.dart';

import '../util.dart';

class UnitDetailsSliderWidget extends StatelessWidget {
  const UnitDetailsSliderWidget(
      {Key? key, required this.unitType, this.showRate = true, this.rate, required this.images, this.discountPercentage})
      : super(key: key);
  final String unitType;
  final bool showRate;
  final double? rate;
  final List<ImageEntity> images;
  final int? discountPercentage;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 17, start: 24, end: 24),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ImageSlideshow(
              indicatorColor: kWhite,
              indicatorBackgroundColor: Theme.of(context).dialogBackgroundColor,
              onPageChanged: (value) {},
              autoPlayInterval: 15000,
              isLoop: true,
              children: images.isEmpty ? [const ErrorCard()] : createImageList(images),
            ),
          ),
          if (discountPercentage != null && ((discountPercentage ?? 0) > 0))
            PositionedDirectional(
              bottom: 12,
              end: 12,
              child: Container(
                decoration: BoxDecoration(
                  color: yellowOrange,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  '${LocaleKeys.discount} $discountPercentage%',
                  style: circularMedium(color: kWhite, fontSize: 14),
                ),
              ),
            ),
          Container(
            margin: const EdgeInsets.all(14),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                showRate
                    ? Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).disabledColor,
                            borderRadius: const BorderRadius.all(Radius.circular(11))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 11),
                          child: Row(
                            children: [
                              Image.asset(starIconPath, color: kWhite),
                              Text(
                                rate.toString(),
                                style: circularMedium(color: kWhite, fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
                Container(
                  /*decoration: BoxDecoration(
                      color: Theme.of(context).dialogBackgroundColor,
                      borderRadius: const BorderRadius.all(Radius.circular(11))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    child: Text(
                      unitType,
                      style: circularMedium(color: Theme.of(context).primaryColorLight, fontSize: 14),
                    ),
                  ),*/
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}