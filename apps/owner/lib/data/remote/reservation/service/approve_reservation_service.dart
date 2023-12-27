import 'package:owner/base/base_service.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class ApproveReservationService extends BaseService {
  Future<ApiResponse> approveReservation(String reservationId) async {
    NetworkRequest request =
        NetworkRequest("$reservationApi/$reservationId/approve", RequestMethod.put, headers: await getHeaders());

    var result = await networkManager.perform(request);
    return result;
  }
}