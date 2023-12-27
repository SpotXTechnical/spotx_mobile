import 'package:dio/dio.dart';
import 'package:owner/base/base_service.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class PostPaymentService extends BaseService {
  Future<ApiResponse> postPayment(String unitId, String date, String amount, String description) async {
    Map<String, dynamic> formData = {
      "unit_id": unitId,
      "date": date,
      "amount": amount,
      "description": description,
    };

    final FormData data = FormData.fromMap(formData);

    NetworkRequest request = NetworkRequest(paymentApi, RequestMethod.post, headers: await getHeaders(), data: data);

    var result = await networkManager.perform(request);

    return result;
  }
}
