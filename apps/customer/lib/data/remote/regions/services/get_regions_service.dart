import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_list_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class GetRegionsService extends BaseService {
  Future<ApiResponse> getRegions(
      {int? subRegionCount, int? regionId, int perPage = perPage, int? withSubRegion, int? mostPopular}) async {
    Map<String, String> queryParams = <String, String>{};
    queryParams["per_page"] = perPage.toString();
    if (subRegionCount != null) queryParams["subRegion_count"] = subRegionCount.toString();
    if (withSubRegion != null) queryParams["with_sub"] = withSubRegion.toString();
    if (mostPopular != null) queryParams["most_popular"] = mostPopular.toString();

    regionId != 0 ? queryParams["region"] = regionId.toString() : "";

    NetworkRequest request =
        NetworkRequest(getRegionsApi, RequestMethod.get, headers: await getHeaders(), queryParams: queryParams);

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseListResponse.fromJson(result.data, (json) => Region.fromJson(json));
    }
    return result;
  }
}
