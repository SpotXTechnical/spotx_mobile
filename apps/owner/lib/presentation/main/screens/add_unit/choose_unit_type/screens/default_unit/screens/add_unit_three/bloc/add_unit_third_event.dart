import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';

abstract class AddUnitThirdEvent extends Equatable {
  const AddUnitThirdEvent();
}

class AddUnitThirdHideError extends AddUnitThirdEvent {
  const AddUnitThirdHideError();
  @override
  List<Object?> get props => [];
}

class AddCheckInTime extends AddUnitThirdEvent {
  final TimeOfDay checkInTime;
  final String checkInString;
  const AddCheckInTime(this.checkInTime, this.checkInString);
  @override
  List<Object?> get props => [checkInTime, checkInString];
}

class AddCheckOutTime extends AddUnitThirdEvent {
  final TimeOfDay checkOutTime;
  final String checkOutString;
  const AddCheckOutTime(this.checkOutTime, this.checkOutString);
  @override
  List<Object?> get props => [checkOutTime, checkOutString];
}

class GetRegionsWithSubRegion extends AddUnitThirdEvent {
  const GetRegionsWithSubRegion();

  @override
  List<Object?> get props => [];
}

class SetRegion extends AddUnitThirdEvent {
  final Region region;

  const SetRegion(this.region);

  @override
  List<Object?> get props => [region];
}

class SetSelectedSubRegion extends AddUnitThirdEvent {
  final Region subRegion;

  const SetSelectedSubRegion(this.subRegion);

  @override
  List<Object?> get props => [subRegion];
}

class IncrementRoomNumberEvent extends AddUnitThirdEvent {
  const IncrementRoomNumberEvent();

  @override
  List<Object?> get props => [];
}

class IncrementBedNumberEvent extends AddUnitThirdEvent {
  const IncrementBedNumberEvent();

  @override
  List<Object?> get props => [];
}

class DecrementRoomNumberEvent extends AddUnitThirdEvent {
  const DecrementRoomNumberEvent();

  @override
  List<Object?> get props => [];
}

class DecrementBedNumberEvent extends AddUnitThirdEvent {
  const DecrementBedNumberEvent();

  @override
  List<Object?> get props => [];
}

class MoveToFourthScreenEvent extends AddUnitThirdEvent {
  final Unit unit;
  const MoveToFourthScreenEvent(this.unit);

  @override
  List<Object?> get props => [unit];
}

class IncrementBathNumberEvent extends AddUnitThirdEvent {
  const IncrementBathNumberEvent();

  @override
  List<Object?> get props => [];
}

class DecrementBathNumberEvent extends AddUnitThirdEvent {
  const DecrementBathNumberEvent();

  @override
  List<Object?> get props => [];
}

class IncrementGuestsNumberEvent extends AddUnitThirdEvent {
  const IncrementGuestsNumberEvent();

  @override
  List<Object?> get props => [];
}

class DecrementGuestsNumberEvent extends AddUnitThirdEvent {
  const DecrementGuestsNumberEvent();

  @override
  List<Object?> get props => [];
}

class GetRegionById extends AddUnitThirdEvent {
  final String regionId;

  const GetRegionById({required this.regionId});

  @override
  List<Object?> get props => [regionId];
}
