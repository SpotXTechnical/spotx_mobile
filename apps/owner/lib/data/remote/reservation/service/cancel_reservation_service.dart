import 'package:owner/base/base_service.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class CancelReservationService extends BaseService {

  Future<ApiResponse> cancelReservation(String reservationId) async {
    NetworkRequest request = NetworkRequest(
      "$reservationApi/$reservationId/cancel",
      RequestMethod.put,
      headers: await getHeaders(),
    );

    var result = await networkManager.perform(request);

    return result;
  }
}