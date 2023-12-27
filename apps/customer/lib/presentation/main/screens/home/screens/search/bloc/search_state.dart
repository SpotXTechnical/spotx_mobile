import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/data/remote/unit/model/filter_queryies.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

class SearchState extends Equatable {
  const SearchState(
      {this.units,
      this.isLoading = false,
      this.hasMore = false,
      this.filterQueries,
      this.isRegionListLoading = false,
      this.regions,
      this.isRegionListError = false,
      this.isError = false,
      this.selectedRegions});
  final List<Unit>? units;
  final List<Region>? regions;
  final bool isLoading;
  final bool hasMore;
  final bool isError;
  final bool isRegionListLoading;
  final bool isRegionListError;
  final FilterQueries? filterQueries;
  final List<Region>? selectedRegions;
  @override
  List<Object?> get props =>
      [units, isLoading, hasMore, regions, isRegionListLoading, isRegionListError, isError, selectedRegions];

  SearchState copyWith(
      {FilterQueries? filterQueries,
      bool? hasMore,
      bool? isLoading,
      bool? isRegionListLoading,
      List<Unit>? units,
      List<Region>? regions,
      bool? isRegionListError,
      bool? isError,
      List<Region>? selectedRegions}) {
    return SearchState(
        filterQueries: filterQueries ?? this.filterQueries,
        hasMore: hasMore ?? this.hasMore,
        isLoading: isLoading ?? this.isLoading,
        isRegionListLoading: isRegionListLoading ?? this.isRegionListLoading,
        units: units ?? this.units,
        regions: regions ?? this.regions,
        isRegionListError: isRegionListError ?? this.isRegionListError,
        isError: isError ?? this.isError,
        selectedRegions: selectedRegions ?? this.selectedRegions);
  }
}

class InitialSearchState extends SearchState {
  const InitialSearchState() : super();
}
