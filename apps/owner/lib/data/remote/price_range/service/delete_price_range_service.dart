import 'package:dio/dio.dart';
import 'package:owner/base/base_service.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class DeletePriceRangeService extends BaseService {
  Future<ApiResponse> deletePriceRange(String rangeId) async {
    Map<String, dynamic> formData = {};

    FormData.fromMap(formData);

    NetworkRequest request = NetworkRequest('$getUnitsApi/ranges/$rangeId/delete', RequestMethod.delete,
        headers: await getHeaders(), data: FormData.fromMap(formData));

    var result = await networkManager.perform(request);

    return result;
  }
}
