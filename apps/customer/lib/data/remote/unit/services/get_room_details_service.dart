import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/unit/model/room_details_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class GetRoomDetailsService extends BaseService {
  Future<ApiResponse> getRoomDetails(int id) async {
    NetworkRequest request = NetworkRequest(roomDetailsApi + "/$id", RequestMethod.get, headers: await getHeaders());

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => RoomDetailsData.fromJson(json));
    }
    return result;
  }
}
