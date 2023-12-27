import 'package:owner/base/base_service.dart';

class LogoutService extends BaseService {
  logout() {
    // NetworkRequest request = NetworkRequest(getSubDomainBaseUrl(sharedPrefsManager.subDomain) + logOut, RequestMethod.get,
    //     headers: await getHeaders(),
    //     data: {"platform": await platform});
    // await networkManager.perform(request);
    sharedPrefsManager.credentials = null;
  }
}
