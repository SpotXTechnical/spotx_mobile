import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

abstract class FavouriteEvent extends Equatable {}

class GetFavouriteUnits extends FavouriteEvent {
  GetFavouriteUnits();

  @override
  List<Object?> get props => [];
}

class LoadMoreFavouriteUnits extends FavouriteEvent {
  LoadMoreFavouriteUnits();

  @override
  List<Object?> get props => [];
}

class RemoveUnFavouriteUnitEvent extends FavouriteEvent {
  final Unit unit;
  RemoveUnFavouriteUnitEvent(this.unit);
  @override
  List<Object?> get props => [unit];
}
