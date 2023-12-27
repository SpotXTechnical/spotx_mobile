import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_list_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class GetSubRegionsService extends BaseService {
  Future<ApiResponse> getSubRegions(
      {required List regionsIds, int? page, String? searchQuery, int perPage = perPage}) async {
    Map<String, String> queryParams = {};
    queryParams['per_page'] = perPage.toString();
    if (page != null) queryParams['page'] = page.toString();
    if (searchQuery != null) queryParams['name'] = searchQuery;
    regionsIds.asMap().forEach((key, value) {
      queryParams["regions[$key]"] = value.toString();
    });

    NetworkRequest request =
        NetworkRequest("$getSubRegionsApi", RequestMethod.get, headers: await getHeaders(), queryParams: queryParams);

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseListResponse.fromJson(result.data, (json) => Region.fromJson(json));
    }

    return result;
  }
}
