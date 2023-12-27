import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';

class SubRegionState extends Equatable {
  SubRegionState({this.subRegions, this.hasMoreSubRegions = false, this.isLoading = false, this.isError = false});
  final List<Region>? subRegions;
  final bool hasMoreSubRegions;
  final bool isLoading;
  final bool isError;

  @override
  List<Object?> get props => [subRegions, hasMoreSubRegions, isError];

  SubRegionState copyWith({List<Region>? subRegions, bool? hasMoreSubRegions, bool? isLoading, bool? isError}) {
    return SubRegionState(
        subRegions: subRegions ?? this.subRegions,
        hasMoreSubRegions: hasMoreSubRegions ?? this.hasMoreSubRegions,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError);
  }
}
