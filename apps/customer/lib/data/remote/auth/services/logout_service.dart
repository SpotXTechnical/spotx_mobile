import 'package:spotx/base/base_service.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';

class LogoutService extends BaseService {
  logout() {
    // NetworkRequest request = NetworkRequest(getSubDomainBaseUrl(sharedPrefsManager.subDomain) + logOut, RequestMethod.get,
    //     headers: await getHeaders(),
    //     data: {"platform": await platform});
    // await networkManager.perform(request);
    sharedPrefsManager.credentials = null;
  }
}
