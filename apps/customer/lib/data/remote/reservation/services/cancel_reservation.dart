import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/reservation/model/get_reservations_response_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_list_response.dart';
import 'package:spotx/utils/network/base_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class CancelReservation extends BaseService {
  Future<ApiResponse> cancelReservation(String reservationId) async {
    NetworkRequest request =
        NetworkRequest(reservationApi + "/$reservationId" + "/cancel", RequestMethod.put, headers: await getHeaders());

    var result = await networkManager.perform(request);

    return result;
  }
}
