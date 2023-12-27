import 'package:dio/dio.dart';
import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/auth/models/company_code_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class CompanyCodeService extends BaseService {
  Future<ApiResponse> applyCompanyService(String code) async {
    Map<String, dynamic> formData = {"code": code};

    final FormData data = FormData.fromMap(formData);

    final request = NetworkRequest(
      companyCodeApi,
      RequestMethod.post,
      headers: await getHeaders(),
      data: data,
    );

    var result = await networkManager.perform(request);
    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(
          result.data, (json) => CompanyCodeEntity.fromJson(json));
    }
    return result;
  }
}