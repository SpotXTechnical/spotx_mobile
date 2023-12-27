import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

abstract class SubRegionEvent extends Equatable {}

class SubRegionGetUnitsEvent extends SubRegionEvent {
  final int subRegionId;

  SubRegionGetUnitsEvent(this.subRegionId);

  @override
  List<Object?> get props => [subRegionId];
}

class SubRegionLoadMoreUnitsEvent extends SubRegionEvent {
  final int subRegionId;
  SubRegionLoadMoreUnitsEvent(this.subRegionId);

  @override
  List<Object?> get props => [subRegionId];
}

class UpdateSubRegionUnitsEvent extends SubRegionEvent {
  final List<Unit> units;
  UpdateSubRegionUnitsEvent(this.units);
  @override
  List<Object?> get props => [units];
}

class GetSubRegionEvent extends SubRegionEvent {
  final int subRegionId;

  GetSubRegionEvent(this.subRegionId);

  @override
  List<Object?> get props => [subRegionId];
}