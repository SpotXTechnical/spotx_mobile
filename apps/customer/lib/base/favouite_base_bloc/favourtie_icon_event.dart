import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

abstract class FavouriteIconEvent extends Equatable {}

class AddToFavouriteEvent extends FavouriteIconEvent {
  AddToFavouriteEvent();
  @override
  List<Object?> get props => [];
}

class RemoveFromFavouriteEvent extends FavouriteIconEvent {
  RemoveFromFavouriteEvent();
  @override
  List<Object?> get props => [];
}

class UpdateFavouriteUnitEvent extends FavouriteIconEvent {
  final Unit unit;
  UpdateFavouriteUnitEvent(this.unit);
  @override
  List<Object?> get props => [unit];
}
