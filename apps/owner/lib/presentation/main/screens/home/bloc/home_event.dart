import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetHomeCampsEvent extends HomeEvent {
  const GetHomeCampsEvent();

  @override
  List<Object?> get props => [];
}

class GetRegionsEvent extends HomeEvent {
  const GetRegionsEvent();

  @override
  List<Object?> get props => [];
}

class GetUserEvent extends HomeEvent {
  const GetUserEvent();

  @override
  List<Object?> get props => [];
}

class GetRegionUnitsEvent extends HomeEvent {
  final List<int> regionId;
  const GetRegionUnitsEvent(this.regionId);

  @override
  List<Object?> get props => [regionId];
}

class SelectAllRegions extends HomeEvent {
  const SelectAllRegions();

  @override
  List<Object?> get props => [];
}

class GetUnitById extends HomeEvent {
  final String id;
  const GetUnitById(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteUnit extends HomeEvent {
  final String id;
  const DeleteUnit(this.id);

  @override
  List<Object?> get props => [id];
}
