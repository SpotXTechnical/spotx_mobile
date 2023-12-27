import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:owner/data/remote/add_unit/model/image_entity.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/util.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/widgets/CustomClipRect.dart';

class ReservationDetailsSliderWidget extends StatelessWidget {
  const ReservationDetailsSliderWidget({
    Key? key,
    required this.showRate,
    this.rate,
    required this.images,
  }) : super(key: key);
  final bool showRate;
  final double? rate;
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                showRate
                    ? Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).disabledColor,
                            borderRadius: BorderRadius.all(Radius.circular(11))),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}