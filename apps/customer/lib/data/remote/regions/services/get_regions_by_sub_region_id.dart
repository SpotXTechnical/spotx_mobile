import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/regions/models/get_regions_response_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class GetRegionBySubRegionId extends BaseService {
  Future<ApiResponse> getRegionBySubRegionId(int subRegionId) async {
    Map<String, String> queryParams = <String, String>{};
    NetworkRequest request = NetworkRequest("$getMainRegionApi/$subRegionId", RequestMethod.get,
        headers: await getHeaders(), queryParams: queryParams);

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => Region.fromJson(json));
    }
    return result;
  }
}
