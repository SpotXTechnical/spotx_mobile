import 'package:owner/data/remote/region/service/get_owner_regions_service.dart';
import 'package:owner/data/remote/region/service/get_regions_by_id.dart';
import 'package:owner/data/remote/region/service/get_regions_by_sub_region_id.dart';
import 'package:owner/data/remote/region/service/get_regions_service.dart';
import 'package:owner/data/remote/region/service/get_sub_regions_service.dart';
import 'package:owner/utils/network/api_response.dart';

import 'i_region_repository.dart';

class RegionRepository implements IRegionRepository {
  final GetRegionsService _regionService = GetRegionsService();
  final GetOwnerRegionsService _ownerRegionsService = GetOwnerRegionsService();
  final GetSubRegionsService _getSubRegionsService = GetSubRegionsService();
  final GetRegionByIdService _getRegionByIdService = GetRegionByIdService();
  final GetRegionBySubRegionId _getRegionBySubRegionId = GetRegionBySubRegionId();

  @override
  Future<ApiResponse> getRegions(int withSub, {int regionId = 0}) {
    return _regionService.getRegions(withSub, regionId);
  }

  @override
  Future<ApiResponse> getOwnerRegions() {
    return _ownerRegionsService.getOwnerRegions();
  }

  @override
  Future<ApiResponse> getSubRegions({required List regionsIds, int? page, String? searchQuery}) {
    return _getSubRegionsService.getSubRegions(regionsIds: regionsIds, page: page, searchQuery: searchQuery);
  }

  @override
  Future<ApiResponse> getRegionById(int regionId) {
    return _getRegionByIdService.getRegionById(regionId);
  }

  @override
  Future<ApiResponse> getRegionBySubRegionId(int subRegionId) {
    return _getRegionBySubRegionId.getRegionBySubRegionId(subRegionId);
  }
}
