import 'package:dio/dio.dart';
import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/auth/models/register_response_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class RegisterService extends BaseService {
  Future<ApiResponse> register(String name, String email, String phone, int cityId, String password) async {
    Map<String, dynamic> formData = {"email": email, "password": password, "phone": phone, "name": name};

    final FormData data = FormData.fromMap(formData);

    NetworkRequest request = NetworkRequest(registerApi, RequestMethod.post, headers: await getHeaders(), data: data);

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => RegisterResponseEntity.fromJson(json));
    }
    return result;
  }
}