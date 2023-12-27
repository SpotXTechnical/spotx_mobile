import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class UpdateSideMenuIndex extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class UpdateLocale extends HomeEvent {
  final String locale;
  const UpdateLocale(this.locale);
  @override
  List<Object?> get props => [];
}

class LogOut extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class GetRegions extends HomeEvent {
  const GetRegions();
  @override
  List<Object?> get props => [];
}

class GetSubRegions extends HomeEvent {
  const GetSubRegions();
  @override
  List<Object?> get props => [];
}

class GetMostPopularUnits extends HomeEvent {
  const GetMostPopularUnits();
  @override
  List<Object?> get props => [];
}

class AddToFavourite extends HomeEvent {
  final int id;

  const AddToFavourite(this.id);
  @override
  List<Object?> get props => [id];
}

class RemoveFromFavourite extends HomeEvent {
  final int id;

  const RemoveFromFavourite(this.id);
  @override
  List<Object?> get props => [id];
}

class UpdateMostPopularUnitsEvent extends HomeEvent {
  final List<Unit> units;
  const UpdateMostPopularUnitsEvent(this.units);
  @override
  List<Object?> get props => [units];
}

class HomeGetProfileData extends HomeEvent {
  const HomeGetProfileData();
  @override
  List<Object?> get props => [];
}
