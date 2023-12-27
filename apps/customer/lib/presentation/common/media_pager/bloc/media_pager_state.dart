import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/unit/model/offer_entity.dart';

class MediaPagerState extends Equatable {
  final bool isLoading;
  final bool hasMore;
  final List<OfferEntity>? offersList;
  const MediaPagerState({this.isLoading = true, this.hasMore = false, this.offersList});
  @override
  List<Object?> get props => [isLoading, hasMore, offersList];
  MediaPagerState copyWith({bool? isLoading, bool? hasMore, List<OfferEntity>? offersList}) {
    return MediaPagerState(
        isLoading: isLoading ?? this.isLoading,
        hasMore: hasMore ?? this.hasMore,
        offersList: offersList ?? this.offersList);
  }
}
