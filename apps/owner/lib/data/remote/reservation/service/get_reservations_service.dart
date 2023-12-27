import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_list_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class GetReservationsService extends BaseService {
  Future<ApiResponse> getReservations({required int page, int? upcoming, int? past, int? month, String? type, String? unitId}) async {
    Map<String, String> queryParams = <String, String>{};
    queryParams["page"] = page.toString();
    if (upcoming != null) {
      queryParams["upcoming"] = upcoming.toString();
    }
    if (past != null) {
      queryParams["past"] = past.toString();
    }
    if (month != null) {
      queryParams["month"] = month.toString();
    }
    if (type != null) {
      queryParams["type"] = type;
    }
    if (unitId != null) {
      queryParams["unit_id"] = unitId.toString();
    }
    NetworkRequest request = NetworkRequest(reservationApi, RequestMethod.get, headers: await getHeaders(), queryParams: queryParams);

    var result = await networkManager.perform(request);
    if (result.status == Status.OK) {
      result.data = BaseListResponse.fromJson(result.data, (json) => Reservation.fromJson(json));
    }
    return result;
  }
}
