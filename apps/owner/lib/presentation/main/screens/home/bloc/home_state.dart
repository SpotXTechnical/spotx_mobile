import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';

import '../../../../../data/remote/auth/models/login_response_entity.dart';

class HomeState extends Equatable {
  const HomeState(
      {this.camp,
      this.regions,
      this.regionUnits,
      this.isCampLoading = false,
      this.isRegionsLoading = false,
      this.isRegionUnitsLoading = false,
      this.camps,
      this.isCampsLoading = false,
      this.isAllRegionsSelected = true,
      this.selectedRegionId,
      this.isRegionsEmpty = false,
      this.isCampsEmpty = false,
      this.isOnlyOneCamp = false,
      this.user});
  final List<Unit>? camps;
  final Unit? camp;
  final List<Region>? regions;
  final List<Unit>? regionUnits;
  final bool isCampsLoading;
  final bool isCampLoading;
  final bool isRegionsLoading;
  final bool isRegionUnitsLoading;
  final bool isAllRegionsSelected;
  final List<int>? selectedRegionId;
  final bool isCampsEmpty;
  final bool isRegionsEmpty;
  final bool isOnlyOneCamp;
  final User? user;

  @override
  List<Object?> get props => [
        camps,
        camp,
        regions,
        regionUnits,
        isCampsLoading,
        isCampLoading,
        isRegionsLoading,
        isRegionUnitsLoading,
        isAllRegionsSelected,
        selectedRegionId,
        isCampsEmpty,
        isRegionsEmpty,
        isOnlyOneCamp,
        user
      ];

  HomeState copyWith(
      {Unit? camp,
      List<Unit>? camps,
      bool? isCampLoading,
      bool? isCampsLoading,
      bool? isRegionUnitsLoading,
      bool? isRegionsLoading,
      List<Unit>? regionUnits,
      List<Region>? regions,
      bool? isAllRegionsSelected,
      List<int>? selectedRegionId,
      bool? isCampsEmpty,
      bool? isRegionsEmpty,
      bool? isOnlyOneCamp,
      User? user}) {
    return HomeState(
        camp: camp ?? this.camp,
        camps: camps ?? this.camps,
        isCampLoading: isCampLoading ?? this.isCampLoading,
        isCampsLoading: isCampsLoading ?? this.isCampsLoading,
        isRegionUnitsLoading: isRegionUnitsLoading ?? this.isRegionUnitsLoading,
        isRegionsLoading: isRegionsLoading ?? this.isRegionsLoading,
        regionUnits: regionUnits ?? this.regionUnits,
        regions: regions ?? this.regions,
        isAllRegionsSelected: isAllRegionsSelected ?? this.isAllRegionsSelected,
        selectedRegionId: selectedRegionId ?? this.selectedRegionId,
        isCampsEmpty: isCampsEmpty ?? this.isCampsEmpty,
        isRegionsEmpty: isRegionsEmpty ?? this.isRegionsEmpty,
        isOnlyOneCamp: isOnlyOneCamp ?? this.isOnlyOneCamp,
        user: user ?? this.user);
  }
}
