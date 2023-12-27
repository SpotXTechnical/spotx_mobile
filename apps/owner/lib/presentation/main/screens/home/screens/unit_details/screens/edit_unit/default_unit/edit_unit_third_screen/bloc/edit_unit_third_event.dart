import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';

abstract class EditUnitThirdEvent extends Equatable {
  const EditUnitThirdEvent();
}

class AddUnitThirdHideError extends EditUnitThirdEvent {
  const AddUnitThirdHideError();
  @override
  List<Object?> get props => [];
}

class AddCheckInTime extends EditUnitThirdEvent {
  final TimeOfDay checkInTime;
  final String checkInString;
  const AddCheckInTime(this.checkInTime, this.checkInString);
  @override
  List<Object?> get props => [checkInTime, checkInString];
}

class AddCheckOutTime extends EditUnitThirdEvent {
  final TimeOfDay checkOutTime;
  final String checkOutString;
  const AddCheckOutTime(this.checkOutTime, this.checkOutString);
  @override
  List<Object?> get props => [checkOutTime, checkOutString];
}

class GetRegionsWithSubRegion extends EditUnitThirdEvent {
  const GetRegionsWithSubRegion();

  @override
  List<Object?> get props => [];
}

class SetRegion extends EditUnitThirdEvent {
  final Region region;

  const SetRegion(this.region);

  @override
  List<Object?> get props => [region];
}

class SetSelectedSubRegion extends EditUnitThirdEvent {
  final Region subRegion;

  const SetSelectedSubRegion(this.subRegion);

  @override
  List<Object?> get props => [subRegion];
}

class IncrementRoomNumberEvent extends EditUnitThirdEvent {
  const IncrementRoomNumberEvent();

  @override
  List<Object?> get props => [];
}

class IncrementBedNumberEvent extends EditUnitThirdEvent {
  const IncrementBedNumberEvent();

  @override
  List<Object?> get props => [];
}

class DecrementRoomNumberEvent extends EditUnitThirdEvent {
  const DecrementRoomNumberEvent();

  @override
  List<Object?> get props => [];
}

class DecrementBedNumberEvent extends EditUnitThirdEvent {
  const DecrementBedNumberEvent();

  @override
  List<Object?> get props => [];
}

class MoveToFourthScreenEvent extends EditUnitThirdEvent {
  const MoveToFourthScreenEvent();

  @override
  List<Object?> get props => [];
}

class IncrementBathNumberEvent extends EditUnitThirdEvent {
  const IncrementBathNumberEvent();

  @override
  List<Object?> get props => [];
}

class DecrementBathNumberEvent extends EditUnitThirdEvent {
  const DecrementBathNumberEvent();

  @override
  List<Object?> get props => [];
}
class IncrementGuestsNumberEvent extends EditUnitThirdEvent {
  const IncrementGuestsNumberEvent();

  @override
  List<Object?> get props => [];
}

class DecrementGuestsNumberEvent extends EditUnitThirdEvent {
  const DecrementGuestsNumberEvent();

  @override
  List<Object?> get props => [];
}
class InitEditUnitThirdScreen extends EditUnitThirdEvent {
  final Unit unit;
  final TimeOfDay checkIn;
  final TimeOfDay checkOut;
  final String checkInString;
  final String checkOutString;
  const InitEditUnitThirdScreen(this.unit, this.checkIn, this.checkOut, this.checkInString, this.checkOutString);

  @override
  List<Object?> get props => [unit, checkOut, checkIn, checkInString, checkOutString];
}

class GetSubRegions extends EditUnitThirdEvent {
  final String regionId;
  final bool loadMore;
  final String? searchQuery;

  const GetSubRegions({required this.regionId, this.loadMore = false, this.searchQuery});

  @override
  List<Object?> get props => [regionId, loadMore, searchQuery];
}

class LoadMoreSubRegions extends EditUnitThirdEvent {
  final String regionId;
  final String? searchQuery;

  const LoadMoreSubRegions({required this.regionId, this.searchQuery});

  @override
  List<Object?> get props => [regionId, searchQuery];
}

class GetSubRegionById extends EditUnitThirdEvent {
  final String subRegionId;

  const GetSubRegionById({required this.subRegionId});

  @override
  List<Object?> get props => [subRegionId];
}

class GetRegionBySubRegionId extends EditUnitThirdEvent {
  final String subRegionId;

  const GetRegionBySubRegionId({required this.subRegionId});

  @override
  List<Object?> get props => [subRegionId];
}

class ThirdScreenUpdateUnit extends EditUnitThirdEvent {
  const ThirdScreenUpdateUnit();
  @override
  List<Object?> get props => [];
}
