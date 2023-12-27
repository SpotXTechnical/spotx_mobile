import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class GetUserService extends BaseService {
  Future<ApiResponse> getUser() async {
    NetworkRequest request = NetworkRequest(profileApi, RequestMethod.get, headers: await getHeaders());

    var result = await networkManager.perform(request);

    if (result.status == Status.OK) {
      result.data = BaseResponse.fromJson(result.data, (json) => User.fromJson(json));
    }
    return result;
  }
}
