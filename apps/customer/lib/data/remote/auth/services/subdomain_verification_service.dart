
import 'package:spotx/base/base_service.dart';
import 'package:spotx/utils/network/api_response.dart';
import 'package:spotx/utils/network/const.dart';
import 'package:spotx/utils/network/network_request.dart';
import 'package:spotx/utils/utils.dart';

class SubDomainVerificationService extends BaseService{
  Future<ApiResponse> checkSubDomainVerification(String subDomain) async{

    NetworkRequest request = NetworkRequest(checkDomainExistence, RequestMethod.post,
        headers: {"Accept-Language":isArabic ? 'ar':'en',}
        );

    var result = await networkManager.perform(request);
    if(result.status == Status.OK){
      result.data = true;
    }
    return result;
  }
}