import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class GetUnitByIdService extends BaseService {
  Future<ApiResponse> getUnitById(String id) async {
    NetworkRequest request = NetworkRequest(getUnitsApi + "/$id", RequestMethod.get, headers: await getHeaders());

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => Unit.fromJson(json));
    }
    return result;
  }
}
