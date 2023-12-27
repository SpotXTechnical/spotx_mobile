import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:owner/data/remote/add_unit/model/image_entity.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/CustomClipRect.dart';

import '../util.dart';

class UnitDetailsSliderWidget extends StatelessWidget {
  const UnitDetailsSliderWidget(
      {Key? key, required this.unitType, this.showRate = true, this.rate, required this.images})
      : super(key: key);
  final String unitType;
  final bool showRate;
  final String? rate;
  final List<ImageEntity> images;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 17, start: 24, end: 24),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ImageSlideshow(
              width: double.infinity,
              height: 200,
              initialPage: 0,
              indicatorColor: kWhite,
              indicatorBackgroundColor: Theme.of(context).dialogBackgroundColor,
              onPageChanged: (value) {},
              autoPlayInterval: 15000,
              isLoop: true,
              children: images.isEmpty ? [const ErrorCard()] : createImageList(images),
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
                              Image.asset(starRateIconPath, color: kWhite),
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
                  decoration: BoxDecoration(
                      color: Theme.of(context).dialogBackgroundColor,
                      borderRadius: const BorderRadius.all(Radius.circular(11))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    child: Text(
                      unitType,
                      style: circularMedium(color: Theme.of(context).primaryColorLight, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}