import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class DeleteUnitService extends BaseService {
  Future<ApiResponse> deleteUnit(String id) async {
    NetworkRequest request = NetworkRequest(getUnitsApi + "/$id", RequestMethod.delete, headers: await getHeaders());

    var result = await networkManager.perform(request);

    return result;
  }
}
