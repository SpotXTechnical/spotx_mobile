import 'package:spotx/base/base_service.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_list_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';

class GetRegionsSearchService extends BaseService {
  Future<ApiResponse> getRegionsSearch({
    int? page,
    String? searchQuery,
    int perPage = perPage
  }) async {
    Map<String, String> queryParams = {};
    queryParams['per_page'] = perPage.toString();
    if (page != null) queryParams['page'] = page.toString();

    if (searchQuery != null) queryParams['name'] = searchQuery;

    NetworkRequest request =
        NetworkRequest(regionsSearchApi, RequestMethod.get, headers: await getHeaders(), queryParams: queryParams);

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseListResponse.fromJson(result.data, (json) => Region.fromJson(json));
    }

    return result;
  }
}