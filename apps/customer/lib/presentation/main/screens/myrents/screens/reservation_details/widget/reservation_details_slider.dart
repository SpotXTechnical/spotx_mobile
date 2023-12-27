import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:spotx/data/remote/unit/model/image_entity.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/util.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/widgets/CustomClipRect.dart';

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
              ],
            ),
          )
        ],
      ),
    );
  }
}