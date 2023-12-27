import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class GetUnitByIdService extends BaseService {
  Future<ApiResponse> getUnitById(String id) async {
    NetworkRequest request = NetworkRequest("$getUnitsApi/$id", RequestMethod.get, headers: await getHeaders());

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => Unit.fromJson(json));
    }
    return result;
  }
}