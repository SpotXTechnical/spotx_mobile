import 'package:dio/dio.dart';
import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/data/remote/reservation/model/reservation_entity.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class PostReservationService extends BaseService {
  Future<ApiResponse> postReservation(
      String from, String to, String totalPrice, String unitId, String unitType, User user) async {
    Map<String, dynamic> formData = {
      "from": from,
      "to": to,
      "total_price": totalPrice,
      "unit_id": unitId,
      "unit_type": unitType,
    };

    formData.addAll(addGuest(user));

    FormData.fromMap(formData);

    NetworkRequest request = NetworkRequest(reservationApi, RequestMethod.post,
        headers: await getHeaders(), data: FormData.fromMap(formData));

    var result = await networkManager.perform(request);
    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(
          result.data, (json) => Reservation.fromJson(json));
    }
    return result;
  }

  Map<String, dynamic> addGuest(User user) {
    Map<String, dynamic> map = {};
    map["guest[name]"] = user.name;
    map["guest[phone]"] = user.phone;
    return map;
  }
}