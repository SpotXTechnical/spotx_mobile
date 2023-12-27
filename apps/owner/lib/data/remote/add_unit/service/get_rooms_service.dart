import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/add_unit/model/unit.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_list_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class GetRoomsService extends BaseService {
  Future<ApiResponse> getRooms(String unitId) async {
    NetworkRequest request = NetworkRequest(getUnitsApi + unitId + "rooms", RequestMethod.get, headers: await getHeaders());

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseListResponse.fromJson(result.data, (json) => Room.fromJson(json));
    }
    return result;
  }
}
