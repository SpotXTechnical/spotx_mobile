import 'package:equatable/equatable.dart';
import '../../../../../../../data/remote/regions/models/get_regions_response_entity.dart';

abstract class RegionEvent extends Equatable {}

class GetSubRegions extends RegionEvent {
  final Region region;
  final String? searchQuery;

  GetSubRegions({required this.region, this.searchQuery});

  @override
  List<Object?> get props => [region, searchQuery];
}

class LoadMoreSubRegions extends RegionEvent {
  final Region region;
  final String? searchQuery;

  LoadMoreSubRegions({required this.region, this.searchQuery});

  @override
  List<Object?> get props => [region, searchQuery];
}

class SetSelectedSubRegions extends RegionEvent {
  final List<int>? selectedSubRegionsIds;
  final List<Region>? selectedSubRegions;
  final bool isAllSelected;

  SetSelectedSubRegions({this.selectedSubRegionsIds, this.isAllSelected = false, this.selectedSubRegions});

  @override
  List<Object?> get props => [selectedSubRegionsIds, isAllSelected];
}

class ManageSubRegionInList extends RegionEvent {
  final int selectedSubRegionId;
  final Region? selectedSubRegion;
  ManageSubRegionInList(this.selectedSubRegionId, {this.selectedSubRegion});

  @override
  List<Object?> get props => [selectedSubRegionId, selectedSubRegion];
}

class SetAllSubRegionsSelected extends RegionEvent {
  SetAllSubRegionsSelected();

  @override
  List<Object?> get props => [];
}
