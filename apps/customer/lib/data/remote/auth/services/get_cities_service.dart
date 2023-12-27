import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/auth/models/get_cities_response_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_list_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class GetCitiesService extends BaseService {
  Future<ApiResponse> getCities() async {
    NetworkRequest request = NetworkRequest(getCitiesApi, RequestMethod.get, headers: await getHeaders());

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseListResponse.fromJson(result.data, (json) => City.fromJson(json));
    }
    return result;
  }
}
