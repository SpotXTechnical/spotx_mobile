import 'package:owner/utils/network/api_response.dart';

abstract class IRegionRepository {
  Future<ApiResponse> getRegions(int withSub, {int regionId});
  Future<ApiResponse> getSubRegions({required List regionsIds, int? page, String? searchQuery});
  Future<ApiResponse> getOwnerRegions();
  Future<ApiResponse> getRegionById(int regionId);
  Future<ApiResponse> getRegionBySubRegionId(int subRegionId);
}
