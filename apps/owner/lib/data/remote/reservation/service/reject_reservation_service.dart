import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/data/remote/statistics/model/payment_entity.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_list_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class RejectReservationService extends BaseService {
  Future<ApiResponse> rejectReservation(String reservationId) async {
    Map<String, dynamic> formData = {};
    NetworkRequest request =
        NetworkRequest(reservationApi + "/$reservationId" + "/reject", RequestMethod.put, headers: await getHeaders());

    var result = await networkManager.perform(request);
    return result;
  }
}
