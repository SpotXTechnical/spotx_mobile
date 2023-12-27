import 'package:equatable/equatable.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';

class HomeState extends Equatable {
  final String? generalErrorMessage;
  final bool ourDestinationIsLoading;
  final bool subRegionsSectionIsLoading;
  final bool mostPopularSectionIsLoading;
  final List<Region>? regions;
  final List<Region>? mostPopularRegions;
  final List<Unit>? mostPopularUnits;
  final bool? isError;
  final User? user;
  const HomeState(
      {this.generalErrorMessage,
      this.ourDestinationIsLoading = false,
      this.regions,
      this.mostPopularRegions,
      this.subRegionsSectionIsLoading = false,
      this.mostPopularSectionIsLoading = false,
      this.mostPopularUnits,
      this.isError = false,
      this.user});

  @override
  List<Object?> get props => [
        generalErrorMessage,
        ourDestinationIsLoading,
        subRegionsSectionIsLoading,
        mostPopularSectionIsLoading,
        regions,
        mostPopularRegions,
        mostPopularUnits,
        isError,
        user
      ];

  HomeState copyWith(
      {String? generalErrorMessage,
      bool? ourDestinationIsLoading,
      bool? subRegionsSectionIsLoading,
      bool? mostPopularSectionIsLoading,
      List<Region>? regions,
      List<Region>? mostPopularRegions,
      List<Unit>? mostPopularUnits,
      bool? isError,
      User? user}) {
    return HomeState(
        generalErrorMessage: generalErrorMessage ?? this.generalErrorMessage,
        ourDestinationIsLoading: ourDestinationIsLoading ?? this.ourDestinationIsLoading,
        subRegionsSectionIsLoading: subRegionsSectionIsLoading ?? this.subRegionsSectionIsLoading,
        mostPopularSectionIsLoading: mostPopularSectionIsLoading ?? this.mostPopularSectionIsLoading,
        regions: regions ?? this.regions,
        mostPopularRegions: mostPopularRegions ?? this.mostPopularRegions,
        mostPopularUnits: mostPopularUnits ?? this.mostPopularUnits,
        isError: isError ?? this.isError,
        user: user ?? this.user);
  }
}
