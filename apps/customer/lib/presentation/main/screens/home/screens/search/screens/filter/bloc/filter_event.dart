import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/data/remote/unit/model/filter_queryies.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();
}

class SetHomeType extends FilterEvent {
  final List<String> homeTypeList;

  const SetHomeType(this.homeTypeList);

  @override
  List<Object?> get props => [homeTypeList];
}

class SetRegion extends FilterEvent {
  final List<Region> regionList;

  const SetRegion(this.regionList);

  @override
  List<Object?> get props => [regionList];
}

class SetSubRegion extends FilterEvent {
  final List<Region> subRegionList;

  const SetSubRegion(this.subRegionList);

  @override
  List<Object?> get props => [subRegionList];
}

class SetAllSubRegions extends FilterEvent {
  final List<Region> subRegionList;

  const SetAllSubRegions(this.subRegionList);

  @override
  List<Object?> get props => [subRegionList];
}

class SetRoom extends FilterEvent {
  final List<int> roomList;

  const SetRoom(this.roomList);

  @override
  List<Object?> get props => [roomList];
}

class SetBed extends FilterEvent {
  final List<int> bedList;

  const SetBed(this.bedList);

  @override
  List<Object?> get props => [bedList];
}

class SetValuesRange extends FilterEvent {
  final RangeValues rangeValues;

  const SetValuesRange(this.rangeValues);

  @override
  List<Object?> get props => [rangeValues];
}

class GetFilterData extends FilterEvent {
  final FilterQueries? filterQueries;

  const GetFilterData(this.filterQueries);

  @override
  List<Object?> get props => [filterQueries];
}

class GetRegionsWithSubRegion extends FilterEvent {
  const GetRegionsWithSubRegion();

  @override
  List<Object?> get props => [];
}

class SelectAllRegions extends FilterEvent {
  final List<Region> regionList;
  final bool isAllRegionSelected;
  const SelectAllRegions(this.regionList, this.isAllRegionSelected);

  @override
  List<Object?> get props => [regionList, isAllRegionSelected];
}

class SelectAllHomeTypes extends FilterEvent {
  final List<String> homeTypes;
  final bool isAllHomeTypesSelected;
  const SelectAllHomeTypes(this.homeTypes, this.isAllHomeTypesSelected);

  @override
  List<Object?> get props => [homeTypes, isAllHomeTypesSelected];
}

class SelectAllRoomsNumbers extends FilterEvent {
  final List<int> roomsNumbers;
  final bool isAllRoomsNumbersSelected;
  const SelectAllRoomsNumbers(this.roomsNumbers, this.isAllRoomsNumbersSelected);

  @override
  List<Object?> get props => [roomsNumbers, isAllRoomsNumbersSelected];
}

class SelectAllBedsNumbers extends FilterEvent {
  final List<int> bedsNumbers;
  final bool isAllBedsNumbersSelected;
  const SelectAllBedsNumbers(this.bedsNumbers, this.isAllBedsNumbersSelected);

  @override
  List<Object?> get props => [bedsNumbers, isAllBedsNumbersSelected];
}

class Apply extends FilterEvent {
  const Apply();

  @override
  List<Object?> get props => [];
}

class ResetFilterEvent extends FilterEvent {
  const ResetFilterEvent();

  @override
  List<Object?> get props => [];
}

class SetFilterQuery extends FilterEvent {
  final FilterQueries? filterQueries;
  const SetFilterQuery(this.filterQueries);

  @override
  List<Object?> get props => [filterQueries];
}