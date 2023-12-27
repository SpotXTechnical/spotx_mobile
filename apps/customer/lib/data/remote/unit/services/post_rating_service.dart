import 'package:dio/dio.dart';
import 'package:spotx/base/base_service.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class PostRatingService extends BaseService {
  Future<ApiResponse> postRating(String reservationId, String ownerRate, String unitRate, String message) async {
    Map<String, dynamic> formData = {
      "reservation_id": reservationId,
      "owner_rate": ownerRate,
      "unit_rate": unitRate,
      "message": message
    };

    final FormData data = FormData.fromMap(formData);

    NetworkRequest request = NetworkRequest(ratingApi, RequestMethod.post, headers: await getHeaders(), data: data);

    var result = await networkManager.perform(request);

    return result;
  }
}
