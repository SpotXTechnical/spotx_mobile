import 'package:spotx/base/base_service.dart';
import 'package:spotx/data/remote/auth/models/login_response_entity.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/base_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class GetProfileService extends BaseService {
  Future<ApiResponse> getProfile() async {
    NetworkRequest request = NetworkRequest(getProfileApi, RequestMethod.get, headers: await getHeaders());

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => User.fromJson(json));
    }
    return result;
  }
}
