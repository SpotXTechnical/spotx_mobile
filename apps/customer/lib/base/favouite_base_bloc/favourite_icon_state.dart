import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

class FavouriteIconState extends Equatable {
  final Unit unit;
  const FavouriteIconState(this.unit);

  @override
  List<Object?> get props => [unit];
}

class FavouriteIconUnitState extends FavouriteIconState {
  const FavouriteIconUnitState(Unit unit) : super(unit);
}
