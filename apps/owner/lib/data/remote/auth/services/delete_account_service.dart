import 'package:owner/base/base_service.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class DeleteAccountService extends BaseService {
  Future<ApiResponse> deleteAccount() async {
    NetworkRequest request = NetworkRequest(profileApi, RequestMethod.delete, headers: await getHeaders());

    var result = await networkManager.perform(request);

    return result;
  }
}