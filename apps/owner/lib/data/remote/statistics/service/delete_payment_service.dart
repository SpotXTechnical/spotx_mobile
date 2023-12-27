import 'package:dio/dio.dart';
import 'package:owner/base/base_service.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class DeletePaymentService extends BaseService {
  Future<ApiResponse> deletePayment(String paymentId) async {
    NetworkRequest request =
        NetworkRequest(paymentApi + "/" + paymentId, RequestMethod.delete, headers: await getHeaders());

    var result = await networkManager.perform(request);

    return result;
  }
}
