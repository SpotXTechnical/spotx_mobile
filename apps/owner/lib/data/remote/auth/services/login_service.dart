import 'package:dio/dio.dart';
import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/auth/models/login_request_entity.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class LoginService extends BaseService {
  Future<ApiResponse> login(String phone, String password) async {
    Map<String, dynamic> formData = {
      "identifier": phone,
      "password": password,
    };

    final FormData data = FormData.fromMap(formData);

    NetworkRequest request = NetworkRequest(logIn, RequestMethod.post, headers: await getHeaders(), data: data);

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => LoginResponseEntity.fromJson(json));
    }
    return result;
  }
}
