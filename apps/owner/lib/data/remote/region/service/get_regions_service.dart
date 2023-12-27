import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_list_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class GetRegionsService extends BaseService {
  Future<ApiResponse> getRegions(int withSubRegion, int regionId) async {
    Map<String, String> queryParams = <String, String>{};
    queryParams["with_sub"] = withSubRegion.toString();
    queryParams["per_page"] = "30";
    regionId != 0 ? queryParams["region"] = regionId.toString() : "";
    NetworkRequest request = NetworkRequest(getRegionsApi, RequestMethod.get, headers: await getHeaders(), queryParams: queryParams);

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseListResponse.fromJson(result.data, (json) => Region.fromJson(json));
    }
    return result;
  }
}
