import 'package:spotx/base/base_service.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class UpdateLocaleService extends BaseService {
  updateLocale({required String locale}) async {
    NetworkRequest request = NetworkRequest(updateLocaleEndpoint, RequestMethod.put,
        headers: await getHeaders(),
        data: {"locale":locale});
    await networkManager.perform(request);

  }
}