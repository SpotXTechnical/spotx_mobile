import 'package:owner/base/base_service.dart';
import 'package:owner/data/remote/auth/models/login_response_entity.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/base_list_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class GetGuestsService extends BaseService {
  Future<ApiResponse> getGuests(int page) async {
    Map<String, String> queryParams = <String, String>{};
    queryParams["page"] = page.toString();
    NetworkRequest request = NetworkRequest(guestsApi, RequestMethod.get, headers: await getHeaders(), queryParams: queryParams);

    var result = await networkManager.perform(request);
    if (result.status == Status.OK) {
      result.data = BaseListResponse.fromJson(result.data, (json) => User.fromJson(json));
    }
    return result;
  }
}
