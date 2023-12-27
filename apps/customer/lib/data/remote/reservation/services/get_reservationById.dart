import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/reservation/model/get_reservations_response_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class GetReservationById extends BaseService {
  Future<ApiResponse> getReservationById(String reservationId) async {
    NetworkRequest request = NetworkRequest(reservationApi + "/$reservationId", RequestMethod.get, headers: await getHeaders());

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => Reservation.fromJson(json));
    }
    return result;
  }
}
