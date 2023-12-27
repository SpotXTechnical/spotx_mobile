import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';

abstract class RegionEvent extends Equatable {
  const RegionEvent();
}

class InitRegionsAndSubRegions extends RegionEvent {
  final List<String>? regionIds;
  final bool loadMore;
  final String? searchQuery;
  final List<Region>? subregionsList;

  const InitRegionsAndSubRegions({required this.regionIds, this.loadMore = false, this.searchQuery, this.subregionsList});

  @override
  List<Object?> get props => [regionIds, loadMore, subregionsList];
}

class InitSubRegions extends RegionEvent {
  final List<String>? regionIds;
  final bool loadMore;
  final String? searchQuery;
  final List<Region>? subregionsList;

  const InitSubRegions({required this.regionIds, this.loadMore = false, this.searchQuery, this.subregionsList});

  @override
  List<Object?> get props => [regionIds, loadMore, subregionsList];
}

class InitRegions extends RegionEvent {


  const InitRegions();

  @override
  List<Object?> get props => [];
}

class LoadMoreRegions extends RegionEvent {
  const LoadMoreRegions();
  @override
  List<Object?> get props => [];
}

class LoadMoreSubRegions extends RegionEvent {
  final List<String>? regionIds;

  const LoadMoreSubRegions({
    required this.regionIds,
  });

  @override
  List<Object?> get props => [
        regionIds,
      ];
}

class AddOrRemoveSelectedSubRegion extends RegionEvent {
  final Region selectedSubRegion;

  const AddOrRemoveSelectedSubRegion({
    required this.selectedSubRegion,
  });

  @override
  List<Object?> get props => [
        selectedSubRegion,
      ];
}

class SetAllSubRegionsSelected extends RegionEvent {
  const SetAllSubRegionsSelected();

  @override
  List<Object?> get props => [];
}