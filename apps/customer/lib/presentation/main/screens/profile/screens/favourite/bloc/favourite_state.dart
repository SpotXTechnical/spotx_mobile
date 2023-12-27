import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

class FavouriteState extends Equatable {
  final bool isLoading;
  final bool hasMore;
  final List<Unit>? unitsList;
  const FavouriteState({this.isLoading = false, required this.hasMore, this.unitsList});
  @override
  List<Object?> get props => [isLoading, hasMore, unitsList];
}

class InitialFavouriteState extends FavouriteState {
  const InitialFavouriteState() : super(isLoading: false, hasMore: false);
}

class FavouriteLoadingState extends FavouriteState {
  const FavouriteLoadingState({required bool isLoading, required bool hasMore})
      : super(hasMore: hasMore, isLoading: isLoading);
}

class FavouriteUnitsState extends FavouriteState {
  const FavouriteUnitsState({required bool hasMore, List<Unit>? units}) : super(hasMore: hasMore, unitsList: units);
}
