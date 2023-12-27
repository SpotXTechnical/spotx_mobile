import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_list_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class GetOwnerRegionsService extends BaseService {
  Future<ApiResponse> getOwnerRegions() async {
    NetworkRequest request = NetworkRequest(getOwnerRegionsApi, RequestMethod.get, headers: await getHeaders());

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseListResponse.fromJson(result.data, (json) => Region.fromJson(json));
    }
    return result;
  }
}
