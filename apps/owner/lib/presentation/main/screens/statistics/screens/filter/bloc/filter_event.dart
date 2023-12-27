import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/statistics/model/statistics_filter.dart';

import '../../../../../../../data/remote/region/model/get_regions_response_entity.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();
}

class GetRegions extends FilterEvent {
  const GetRegions();

  @override
  List<Object?> get props => [];
}

class SetRegionEvent extends FilterEvent {
  final Region selectedRegion;
  const SetRegionEvent(this.selectedRegion);

  @override
  List<Object?> get props => [selectedRegion];
}

class GetUnits extends FilterEvent {
  const GetUnits();

  @override
  List<Object?> get props => [];
}

class SetUnitEvent extends FilterEvent {
  final Unit selectedUnit;
  const SetUnitEvent(this.selectedUnit);

  @override
  List<Object?> get props => [selectedUnit];
}

class AddStartDateEvent extends FilterEvent {
  final DateTime startDate;
  final String localeCode;
  const AddStartDateEvent(this.startDate, this.localeCode);

  @override
  List<Object?> get props => [startDate, localeCode];
}

class AddEndDateEvent extends FilterEvent {
  final DateTime endDate;
  final String localeCode;
  const AddEndDateEvent(this.endDate, this.localeCode);

  @override
  List<Object?> get props => [endDate, localeCode];
}

class SetStatisticsFilter extends FilterEvent {
  final StatisticsFilter? statisticsFilter;
  final String localeCode;
  const SetStatisticsFilter(this.statisticsFilter, this.localeCode);

  @override
  List<Object?> get props => [statisticsFilter, localeCode];
}

class ResetFilter extends FilterEvent {
  const ResetFilter();

  @override
  List<Object?> get props => [];
}
