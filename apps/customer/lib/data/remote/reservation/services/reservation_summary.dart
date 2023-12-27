import 'package:dio/dio.dart';
import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/reservation/model/reservation_summary_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class ReservationSummaryService extends BaseService {
  Future<ApiResponse> getReservationSummary(
      String from, String to, int unitId, String unitType) async {
    Map<String, dynamic> formData = {
      "from": from,
      "to": to,
      "unit_id": unitId,
      "unit_type": unitType
    };

    final FormData data = FormData.fromMap(formData);

    NetworkRequest request = NetworkRequest(summaryApi, RequestMethod.post,
        headers: await getHeaders(), data: data);

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(
          result.data, (json) => ReservationSummaryEntity.fromJson(json));
    }
    return result;
  }
}