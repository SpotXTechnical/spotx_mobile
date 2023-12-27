import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/unit/model/filter_queryies.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

abstract class SearchEvent extends Equatable {}

class GetUnits extends SearchEvent {
  final FilterQueries? filterQueries;
  GetUnits(this.filterQueries);

  @override
  List<Object?> get props => [];
}

class LoadMoreUnits extends SearchEvent {
  LoadMoreUnits();

  @override
  List<Object?> get props => [];
}

class ChangeSortType extends SearchEvent {
  final String sortType;
  ChangeSortType(this.sortType);
  @override
  List<Object?> get props => [];
}

class UpdateSearchUnitsEvent extends SearchEvent {
  final List<Unit> units;
  UpdateSearchUnitsEvent(this.units);
  @override
  List<Object?> get props => [units];
}