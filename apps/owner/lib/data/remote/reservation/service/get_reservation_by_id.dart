import 'package:owner/data/remote/reservation/model/reservation_entity.dart';

import '../../../../base/base_service.dart';
import '../../../../utils/network/api_response.dart';
import '../../../../utils/network/base_response.dart';
import '../../../../utils/network/const.dart';
import '../../../../utils/network/network_request.dart';

class GetReservationByIdService extends BaseService {
  Future<ApiResponse> getReservationById(String reservationId) async {
    NetworkRequest request = NetworkRequest("$reservationApi/$reservationId", RequestMethod.get, headers: await getHeaders());

    var result = await networkManager.perform(request);
    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => Reservation.fromJson(json));
    }
    return result;
  }
}