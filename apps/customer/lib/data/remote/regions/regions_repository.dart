import 'package:spotx/data/remote/regions/services/get_most_popular_regions_service.dart';
import 'package:spotx/data/remote/regions/services/get_region_service.dart';
import 'package:spotx/data/remote/regions/services/get_regions_by_sub_region_id.dart';
import 'package:spotx/data/remote/regions/services/get_regions_search_service.dart';
import 'package:spotx/data/remote/regions/services/get_regions_service.dart';
import 'package:spotx/data/remote/regions/services/get_sub_regions_service.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/data/remote/regions/i_regions_repository.dart';

class RegionsRepository implements IRegionsRepository {
  final _getRegionsService = GetRegionsService();
  final _getRegionService = GetRegionService();
  final _getSubRegionsService = GetSubRegionsService();
  final _getRegion = GetRegionsSearchService();
  final _getRegionBySubRegionId = GetRegionBySubRegionId();
  final _getMostPopularRegionsService = GetMostPopularRegionsService();

  @override
  Future<ApiResponse> getRegions({int? withSubRegions, int? subRegionCount, int regionId = 0, int? mostPopular}) {
    return _getRegionsService.getRegions(
        regionId: regionId, subRegionCount: subRegionCount, withSubRegion: withSubRegions, mostPopular: mostPopular);
  }

  @override
  Future<ApiResponse> getSubRegions({required List<String> regionsIds, int? page, String? searchQuery}) {
    return _getSubRegionsService.getSubRegions(page: page, searchQuery: searchQuery, regionsIds: regionsIds);
  }

  @override
  Future<ApiResponse> getRegionBySubregionId(int subRegionId) {
    return _getRegionBySubRegionId.getRegionBySubRegionId(subRegionId);
  }

  @override
  Future<ApiResponse> getMostPopularRegionsAndSubRegions(int? page) {
    return _getMostPopularRegionsService.getMostPopularRegions(page);
  }

  @override
  Future<ApiResponse> getRegionsSearch({int? page, String? searchQuery}) {
    return _getRegion.getRegionsSearch(page: page, searchQuery: searchQuery);
  }

  @override
  Future<ApiResponse> getRegion(int regionId) {
    return _getRegionService.getRegion(regionId);
  }
}