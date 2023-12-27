import 'package:dio/dio.dart';
import 'package:owner/base/base_service.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class PostNotificationsService extends BaseService {
  Future<ApiResponse> postNotifications(String message, String? unitId, List<String> regionsIds) async {
    Map<String, dynamic> formData = {
      "message": message,
    };

    if (unitId != null) {
      formData.addAll({"unit": unitId});
    }

    formData.addAll(addRegionsIds(regionsIds));

    final FormData data = FormData.fromMap(formData);

    NetworkRequest request =
        NetworkRequest(notificationsApi, RequestMethod.post, headers: await getHeaders(), data: data);

    var result = await networkManager.perform(request);

    return result;
  }

  Map<String, dynamic> addRegionsIds(List<String>? regions) {
    Map<String, dynamic> map = {};
    regions?.asMap().forEach((key, value) {
      map["regions[$key]"] = value;
    });
    return map;
  }
}
