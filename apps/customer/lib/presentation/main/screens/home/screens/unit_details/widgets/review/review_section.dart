import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/widgets/review/widgets/review_card.dart';
import 'package:spotx/utils/widgets/loading_widget.dart';
import 'package:spotx/utils/widgets/pagination/pagination_list.dart';

import '../../../../../../../../data/remote/unit/model/review_entity.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({Key? key, required this.reviews}) : super(key: key);
  final List<ReviewEntity> reviews;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: PaginationList<ReviewEntity>(
        isLoading: false,
        hasMore: false,
        list: reviews,
        loadMore: () {},
        builder: (ReviewEntity review) {
          return ReviewCard(reviewEntity: review);
        },
        onRefresh: () {},
        loadingWidget: const LoadingWidget(),
      ),
    );
  }
}
