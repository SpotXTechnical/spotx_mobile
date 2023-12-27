import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:spotx/data/remote/unit/model/review_entity.dart';
import 'package:spotx/utils/images.dart';
import 'package:spotx/utils/style/theme.dart';
import 'package:spotx/utils/utils.dart';
import 'package:spotx/utils/widgets/CustomClipRect.dart';

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
                      path: reviewEntity.user?.image,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(start: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          reviewEntity.user?.name ?? "User",
                          style: circularMedium(color: kWhite, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        if (reviewEntity.createdAt != null)
                          Text(
                            calculateTimeDifferenceFromNow(reviewEntity.createdAt!),
                            style: helveticRegular(color: cadetGrey, fontSize: 12),
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
                  initialRating: reviewEntity.unitRate?.toDouble() ?? 0.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ignoreGestures: true,
                  itemSize: 18,
                  unratedColor: Theme.of(context).hintColor,
                  itemBuilder: (context, _) => Image.asset(starIconPath, color: Theme.of(context).canvasColor),
                  onRatingUpdate: (rating) {
                    debugPrint("$rating");
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
                  child: Text(reviewEntity.message ?? "",
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