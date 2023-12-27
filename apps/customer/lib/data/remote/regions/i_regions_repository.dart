import 'package:spotx/utils/network/api_response.dart';

abstract class IRegionsRepository {
  Future<ApiResponse> getRegions({int? withSubRegions, int? subRegionCount, int regionId, int? mostPopular});
  Future<ApiResponse> getSubRegions({required List<String> regionsIds, int? page, String? searchQuery});
  Future<ApiResponse> getRegionsSearch({int? page, String? searchQuery});
  Future<ApiResponse> getRegionBySubregionId(int subRegionId);
  Future<ApiResponse> getMostPopularRegionsAndSubRegions(int? page);
  Future<ApiResponse> getRegion(int regionId);
}