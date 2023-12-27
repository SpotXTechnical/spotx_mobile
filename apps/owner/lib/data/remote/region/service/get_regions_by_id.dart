import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/region/model/get_regions_response_entity.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class GetRegionByIdService extends BaseService {
  Future<ApiResponse> getRegionById(int regionId) async {
    Map<String, String> queryParams = <String, String>{};
    NetworkRequest request = NetworkRequest("$getRegionsApi/$regionId", RequestMethod.get,
        headers: await getHeaders(), queryParams: queryParams);

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => Region.fromJson(json));
    }
    return result;
  }
}
