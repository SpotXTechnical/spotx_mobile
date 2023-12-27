import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

class SubRegionState extends Equatable {
  const SubRegionState({
    this.units,
    this.subRegion,
    this.isUnitsLoading = false,
    this.isSubRegionLoading = false,
    this.hasMore = false,
  });

  final bool isUnitsLoading;
  final bool isSubRegionLoading;
  final bool hasMore;
  final Region? subRegion;
  final List<Unit>? units;

  @override
  List<Object?> get props =>
      [units, subRegion, isUnitsLoading, isSubRegionLoading, hasMore];

  SubRegionState copyWith({
    bool? isSubRegionLoading,
    bool? hasMore,
    bool? isUnitsLoading,
    Region? subRegion,
    List<Unit>? units,
  }) {
    return SubRegionState(
      isSubRegionLoading: isSubRegionLoading ?? this.isSubRegionLoading,
      hasMore: hasMore ?? this.hasMore,
      isUnitsLoading: isUnitsLoading ?? this.isUnitsLoading,
      subRegion: subRegion ?? this.subRegion,
      units: units ?? this.units,
    );
  }
}

class InitialSubRegionState extends SubRegionState {
  const InitialSubRegionState() : super();
}