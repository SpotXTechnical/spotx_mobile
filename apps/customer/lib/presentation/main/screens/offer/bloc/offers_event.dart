import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/unit/model/offer_entity.dart';

abstract class OffersEvent extends Equatable {}

class GetOffersUnits extends OffersEvent {
  GetOffersUnits();

  @override
  List<Object?> get props => [];
}

class LoadMoreOffersUnits extends OffersEvent {
  LoadMoreOffersUnits();

  @override
  List<Object?> get props => [];
}

class UpdateOffersUnitsEvent extends OffersEvent {
  final List<OfferEntity> offers;
  UpdateOffersUnitsEvent(this.offers);
  @override
  List<Object?> get props => [offers];
}
