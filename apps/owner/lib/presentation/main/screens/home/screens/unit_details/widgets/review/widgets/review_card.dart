import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:owner/data/remote/add_unit/model/review_entity.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/images.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/table_calender/utils.dart';
import 'package:owner/utils/widgets/CustomClipRect.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key, required this.reviewEntity}) : super(key: key);
  final ReviewEntity reviewEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 39,
                    height: 39,
                    child: CustomClipRect(
                      borderRadius: BorderRadius.circular(500),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(start: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          reviewEntity.user!.name!,
                          style: circularMedium(color: kWhite, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          calculateTimeDifferenceFromNow(reviewEntity.createdAt!) + " " + LocaleKeys.ago.tr(),
                          style: helveticRegular(color: Theme.of(context).dividerColor, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topCenter,
                child: RatingBar.builder(
                  initialRating: reviewEntity.unitRate!.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ignoreGestures: true,
                  itemSize: 18,
                  unratedColor: Theme.of(context).hintColor,
                  itemBuilder: (context, _) => Image.asset(rateBarStarIconPath, color: kWhite),
                  onRatingUpdate: (rating) {
                    debugPrint('$rating');
                  },
                ),
              )
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 54, height: 6),
              Expanded(
                child: Container(
                  margin: const EdgeInsetsDirectional.only(end: 20),
                  child: Text(reviewEntity.message!,
                      style: circularBook(color: Theme.of(context).splashColor, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.justify),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}