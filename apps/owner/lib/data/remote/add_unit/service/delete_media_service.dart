import 'package:owner/base/base_service.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/network/const.dart';
import 'package:owner/utils/network/network_request.dart';

class DeleteMediaService extends BaseService {
  Future<ApiResponse> deleteMedia(String id) async {
    NetworkRequest request = NetworkRequest("$mediaApi/$id", RequestMethod.delete, headers: await getHeaders());
    var result = await networkManager.perform(request);

    return result;
  }
}
