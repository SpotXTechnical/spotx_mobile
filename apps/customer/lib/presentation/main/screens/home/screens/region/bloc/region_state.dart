import 'package:equatable/equatable.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';

class RegionState extends Equatable {
  const RegionState(
      {this.subRegions,
      this.hasMore = false,
      this.requestStatus = RequestStatus.loading,
      this.selectedSubRegionsIds,
      this.isAllSubRegionsSelected = false,
      this.selectedSubRegions});
  final List<Region>? subRegions;
  final RequestStatus requestStatus;
  final bool hasMore;
  final List<int>? selectedSubRegionsIds;
  final List<Region>? selectedSubRegions;
  final bool isAllSubRegionsSelected;

  @override
  List<Object?> get props => [
        subRegions,
        hasMore,
        requestStatus,
        selectedSubRegionsIds,
        selectedSubRegions,
        isAllSubRegionsSelected
      ];
  RegionState copyWith(
      {List<Region>? subRegions, RequestStatus? requestStatus, bool? hasMore, List<int>? selectedSubRegionsIds, bool? isAllSubRegionsSelected,
      List<Region>? selectedSubRegions}) {
    return RegionState(
        subRegions: subRegions ?? this.subRegions,
        requestStatus: requestStatus ?? this.requestStatus,
        hasMore: hasMore ?? this.hasMore,
        isAllSubRegionsSelected: isAllSubRegionsSelected ?? this.isAllSubRegionsSelected,
        selectedSubRegionsIds: selectedSubRegionsIds ?? this.selectedSubRegionsIds,
    selectedSubRegions: selectedSubRegions ?? this.selectedSubRegions);
  }
}
