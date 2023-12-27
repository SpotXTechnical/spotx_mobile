import 'package:spotx/base/base_service.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class DeleteAccountService extends BaseService {
  Future<ApiResponse> deleteAccount() async {
    NetworkRequest request = NetworkRequest(
      getProfileApi,
      RequestMethod.delete,
      headers: await getHeaders(),
    );

    var result = await networkManager.perform(request);

    return result;
  }
}