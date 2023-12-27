import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/unit/model/offer_entity.dart';

class OffersState extends Equatable {
  final bool isLoading;
  final bool hasMore;
  final List<OfferEntity>? offersList;
  const OffersState({this.isLoading = true,  this.hasMore = false, this.offersList});
  @override
  List<Object?> get props => [isLoading, hasMore, offersList];
  OffersState copyWith({bool? isLoading, bool? hasMore, List<OfferEntity>? offersList}){
    return OffersState(
      isLoading: isLoading?? this.isLoading,
      hasMore: hasMore?? this.hasMore,
      offersList: offersList?? this.offersList
    );
}
}
