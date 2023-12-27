import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_list_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class GetMostPopularRegionsService extends BaseService {
  Future<ApiResponse> getMostPopularRegions(int? page) async {
    Map<String, String> queryParams = <String, String>{};
    queryParams["per_page"] = perPage.toString();
    if (page != null) queryParams['page'] = page.toString();

    NetworkRequest request =
        NetworkRequest(mostPopularRegion, RequestMethod.get, headers: await getHeaders(), queryParams: queryParams);

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseListResponse.fromJson(result.data, (json) => Region.fromJson(json));
    }
    return result;
  }
}
